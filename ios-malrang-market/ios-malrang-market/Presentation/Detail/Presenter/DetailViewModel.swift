//
//  DetailViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxSwift

protocol DetailViewModelOutput {
    var productInfomation: Observable<ProductInfomation>? { get }
    var productImagesURLString: Observable<[String]>? { get }
    var error: Observable<Error>? { get }
    var product: ProductInfomation? { get }
}

protocol DetailViewModelable: DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelable {
    private let disposeBag = DisposeBag()

    init(
        productId: Int,
        useCase: UsecaseProtocol
    ) {
        useCase.fetchProductDetail(id: productId)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, product in
                viewModel.productInfomation = .just(product)
                viewModel.productImagesURLString = .just(product.images.map { $0.url })
                viewModel.product = product
            }, onError: { error in
                self.error = .just(error)
            })
            .disposed(by: self.disposeBag)
    }

    // MARK: - Output

    var error: Observable<Error>?
    var productInfomation: Observable<ProductInfomation>?
    var productImagesURLString: Observable<[String]>?
    var product: ProductInfomation?
}
