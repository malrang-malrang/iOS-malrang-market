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
    var productInfomation: Observable<ProductDetail> { get }
    var productImageList: Observable<[ImageInfo]> { get }
    var error: Observable<Error>? { get }
}

protocol ManagementViewModelable: ManagementViewModelInput, ManagementViewModelOutput {}

final class ManagementViewModel: ManagementViewModelable, NotificationPostable {
    private let productId: Int?
    private let useCase: Usecase
    var error: Observable<Error>?

    private var productRelay = BehaviorRelay<[ProductDetail]>(value: [])
    var productInfomation: Observable<ProductDetail> {
        return self.productRelay.compactMap { $0.last }.asObservable()
    }

    private let imageRelay = BehaviorRelay<[ImageInfo]>(value: [])
    var productImageList: Observable<[ImageInfo]> {
        return self.imageRelay.asObservable()
    }

    init(
        productId: Int? = nil,
        useCase: Usecase
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
                product.images?.forEach {
                    let image = $0.url?.image()
                    guard let imageData = image?.jpegData(compressionQuality: 1) else {
                        return
                    }
                    self.insert(imageData: imageData)
                }
            }, onError: { error in
                self.error = .just(error)
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
                self?.error = .just(error)
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
