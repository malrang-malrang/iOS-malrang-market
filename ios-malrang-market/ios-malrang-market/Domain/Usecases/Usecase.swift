//
//  File.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift

protocol Usecase {
    func fetchProductList(pageNumber: Int, perPages: Int) -> Observable<ProductList>
    func fetchProductDetail(id: Int) -> Observable<ProductDetail>
    func post(_ productRequest: ProductRequest) -> Observable<ProductDetail>
}

struct DefaultUsecase: Usecase {
    private let malrangMarketRepository: MalrangMarketRepositoryProtocol

    init(malrangMarketRepository: MalrangMarketRepositoryProtocol) {
        self.malrangMarketRepository = malrangMarketRepository
    }

    func fetchProductList(pageNumber: Int, perPages: Int) -> Observable<ProductList> {
        return self.malrangMarketRepository.fetchProductList(
            pageNumber: pageNumber,
            perPages: perPages
        )
    }

    func fetchProductDetail(id: Int) -> Observable<ProductDetail> {
        return self.malrangMarketRepository.fetchProductDetail(id: id)
    }

    func post(_ productRequest: ProductRequest) -> Observable<ProductDetail> {
        return self.malrangMarketRepository.post(product: productRequest)
    }
}
