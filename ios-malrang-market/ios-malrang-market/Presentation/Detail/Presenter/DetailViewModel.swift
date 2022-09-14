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
    func productDetail() -> ProductDetail?
}

protocol DetailViewModelOutput {
    var productInfomation: Observable<ProductDetail> { get }
    var imagesString: Observable<[String]> { get }
    var error: Observable<Error>? { get }
}

protocol DetailViewModelable: DetailViewModelInput, DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelable {
    private let productId: Int?
    private let useCase: Usecase
    var error: Observable<Error>?

    private var productRelay = BehaviorRelay<[ProductDetail]>(value: [])
    var productInfomation: Observable<ProductDetail> {
        return self.productRelay.compactMap { $0.last }.asObservable()
    }

    private let imageRelay = BehaviorRelay<[String]>(value: [])
    var imagesString: Observable<[String]> {
        self.imageRelay.asObservable()
    }

    init(
        productId: Int?,
        useCase: Usecase
    ) {
        self.productId = productId
        self.useCase = useCase
        self.fetchProductDetail(id: self.productId)
    }

    private func fetchProductDetail(id: Int?) {
        guard let id = id else {
            return self.error = .just(InputError.productId)
        }

        _ = self.useCase.fetchProductDetail(id: id)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, product in
                viewModel.productRelay.accept([product])
                let imageStringList = product.images?.compactMap { $0.url }
                if let imageStringList = imageStringList {
                    return viewModel.imageRelay.accept(imageStringList)
                }
            }, onError: { error in
                self.error = .just(error)
            })
    }

    func productDetail() -> ProductDetail? {
        return self.productRelay.value.last
    }
}
