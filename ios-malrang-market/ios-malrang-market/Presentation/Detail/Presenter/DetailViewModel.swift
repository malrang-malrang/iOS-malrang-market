//
//  DetailViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxCocoa
import RxSwift
import RxRelay

protocol DetailViewModelInput {
    func productDetail() -> ProductInfomation?
}

protocol DetailViewModelOutput {
    var productInfomation: Observable<ProductInfomation> { get }
    var imagesString: Observable<[String]> { get }
    var error: Observable<Error> { get }
}

protocol DetailViewModelable: DetailViewModelInput, DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelable {
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

    private let imageRelay = BehaviorRelay<[String]>(value: [])
    var imagesString: Observable<[String]> {
        self.imageRelay.asObservable()
    }

    init(
        productId: Int?,
        useCase: UsecaseProtocol
    ) {
        self.productId = productId
        self.useCase = useCase
        self.fetchProductDetail(id: self.productId)
    }

    private func fetchProductDetail(id: Int?) {
        guard let id = id else {
            return self.errorRelay.accept(InputError.productId)
        }

        _ = self.useCase.fetchProductDetail(id: id)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, product in
                viewModel.productRelay.accept([product])
                let imageURLList = product.images.compactMap { $0.url.description }
                return viewModel.imageRelay.accept(imageURLList)
            }, onError: { error in
                self.errorRelay.accept(error)
            })
    }

    func productDetail() -> ProductInfomation? {
        return self.productRelay.value.last
    }
}
