//
//  File.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift

protocol Usecase {
    func fetchProductList(endPoint: EndPoint) -> Single<ProductList?>
    func fetchProductDetail(endPoint: EndPoint) -> Single<ProductDetail?>
}

struct DefaultUsecase: Usecase {
    private let productListRepository: ProductListRepositoryProtocol
    private let productDetailRepository: ProductDetailRepositoryProtocol

    init(
        listRepository: ProductListRepositoryProtocol,
        detailRepository: ProductDetailRepositoryProtocol
    ) {
        self.productListRepository = listRepository
        self.productDetailRepository = detailRepository
    }

    func fetchProductList(endPoint: EndPoint) -> Single<ProductList?> {
        return self.productListRepository.fetch(endPoint: endPoint)
    }

    func fetchProductDetail(endPoint: EndPoint) -> Single<ProductDetail?> {
        return self.productDetailRepository.fetch(endPoint: endPoint)
    }
}
