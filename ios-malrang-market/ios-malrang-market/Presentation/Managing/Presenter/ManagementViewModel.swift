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
    func productPost(_ product: ProductRequest, completion: @escaping () -> Void)
}

protocol ManagementViewModelOutput {
    var productInfomation: Observable<ProductInfomation> { get }
    var productImageList: Observable<[ImageInfo]> { get }
    var error: Observable<Error> { get }
    func imageList() -> [ImageInfo]
}

protocol ManagementViewModelable: ManagementViewModelInput, ManagementViewModelOutput {}

final class ManagementViewModel: ManagementViewModelable, NotificationPostable {
    private let errorRelay = ReplayRelay<Error>.create(bufferSize: 1)
    private var productRelay = ReplayRelay<ProductInfomation>.create(bufferSize: 1)
    private let imageRelay = BehaviorRelay<[ImageInfo]>(value: [])
    private let useCase: UsecaseProtocol
    private let disposeBag = DisposeBag()

    init(
        productId: Int? = nil,
        useCase: UsecaseProtocol
    ) {
        self.useCase = useCase

        guard let id = productId else {
            return
        }

        useCase.fetchProductDetail(id: id)
            .withUnretained(self)
            .subscribe { viewModel, product in
                viewModel.productRelay.accept(product)
                let imageURLList = product.images.map { $0.url }
                viewModel.imageDownload(imageURLList: imageURLList)
            } onError: { error in
                self.errorRelay.accept(error)
            }
            .disposed(by: self.disposeBag)
    }

        // MARK: - Input

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
                .subscribe(onError: { [weak self] error in
                    self?.errorRelay.accept(error)
                }, onCompleted: {
                    self.postNotification()
                    completion()
                })
        }

        // MARK: - Output

    var error: Observable<Error> {
        return self.errorRelay.asObservable()
    }

    var productInfomation: Observable<ProductInfomation> {
        return self.productRelay.asObservable()
    }

    var productImageList: Observable<[ImageInfo]> {
        return self.imageRelay.asObservable()
    }
}

extension ManagementViewModel {
    private func imageDownload(imageURLList: [String]) {
        imageURLList.forEach { [weak self] urlString in
            ImageDownloader.default.download(with: urlString) { result in
                switch result {
                case .success(let image):
                    guard let imageData = image.jpegData(compressionQuality: 1) else {
                        return
                    }
                    self?.insert(imageData: imageData)
                case .failure(let error):
                    self?.errorRelay.accept(error)
                }
            }
        }
    }

    private func generateImageName() -> String {
        return UUID().uuidString + Const.dotJPG
    }
}
