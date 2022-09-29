//
//  ManagementViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/12.
//

import RxRelay
import RxSwift

private enum Const {
    static let dotJPG = ".jpg"
    static let jpg = "jpg"
}

protocol ManagementViewModelInput {
    func insert(imageData: Data)
    func imageList() -> [ImageInfo]
    func productPost(_ product: ProductRequest, completion: @escaping () -> Void)
}

protocol ManagementViewModelOutput {
    var productInfomation: Observable<ProductInfomation> { get }
    var productImageList: Observable<[ImageInfo]> { get }
    var error: Observable<Error> { get }
}

protocol ManagementViewModelable: ManagementViewModelInput, ManagementViewModelOutput {}

final class ManagementViewModel: ManagementViewModelable, NotificationPostable {
    private let productId: Int?
    private let useCase: UsecaseProtocol

    private let errorRelay = PublishRelay<Error>()
    var error: Observable<Error> {
        return self.errorRelay.asObservable()
    }

    private var productRelay = BehaviorRelay<[ProductInfomation]>(value: [])
    var productInfomation: Observable<ProductInfomation> {
        return self.productRelay.compactMap { $0.last }.asObservable()
    }

    private let imageRelay = BehaviorRelay<[ImageInfo]>(value: [])
    var productImageList: Observable<[ImageInfo]> {
        return self.imageRelay.asObservable()
    }

    init(
        productId: Int? = nil,
        useCase: UsecaseProtocol
    ) {
        self.productId = productId
        self.useCase = useCase
        self.fetchProductDetail(id: self.productId)
    }

    private func fetchProductDetail(id: Int?) {
        guard let id = id else {
            return
        }
        _ = self.useCase.fetchProductDetail(id: id)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, product in
                viewModel.productRelay.accept([product])
                product.images.forEach {
                    ImageDownloader.default.download(with: $0.url) { result in
                        switch result {
                        case .success(let image):
                            guard let imageData = image.jpegData(compressionQuality: 1) else {
                                return
                            }
                            viewModel.insert(imageData: imageData)
                        case .failure(let error):
                            viewModel.errorRelay.accept(error)
                        }
                    }
                }
            }, onError: { error in
                self.errorRelay.accept(error)
            })
    }

    func insert(imageData: Data) {
        let imageInfo = ImageInfo(
            fileName: self.generateImageName(),
            data: imageData,
            type: Const.jpg
        )
        self.imageRelay.accept([imageInfo])
    }

    func imageList() -> [ImageInfo] {
        return self.imageRelay.value
    }

    func productPost(_ product: ProductRequest, completion: @escaping () -> Void) {
        _ = self.useCase.post(product)
            .observe(on: MainScheduler.instance)
            .subscribe(onError: { [weak self] error in
                self?.errorRelay.accept(error)
            }, onCompleted: {
                self.postNotification()
                completion()
            })
    }
}

extension ManagementViewModel {
    private func generateImageName() -> String {
        return UUID().uuidString + Const.dotJPG
    }
}
