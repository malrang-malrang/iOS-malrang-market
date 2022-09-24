//
//  File.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift

protocol Usecase {
    func fetchProductCatalog(pageNumber: Int, perPages: Int) -> Observable<([ProductDetail], Bool)>
    func fetchProductDetail(id: Int) -> Observable<ProductDetail>
    func post(_ productRequest: ProductRequest) -> Observable<Void>
}

struct DefaultUsecase: Usecase {
    private let malrangMarketRepository: MalrangMarketRepositoryProtocol

    init(malrangMarketRepository: MalrangMarketRepositoryProtocol) {
        self.malrangMarketRepository = malrangMarketRepository
    }

    func fetchProductCatalog(pageNumber: Int, perPages: Int) -> Observable<([ProductDetail], Bool)> {
        return self.malrangMarketRepository.fetchProductList(
            pageNumber: pageNumber,
            perPages: perPages
        )
        .map { ($0.pages ?? [], $0.hasNext ?? false) }
    }

    func fetchProductDetail(id: Int) -> Observable<ProductDetail> {
        return self.malrangMarketRepository.fetchProductDetail(id: id)
    }

    func post(_ productRequest: ProductRequest) -> Observable<Void> {
        return self.malrangMarketRepository.post(product: productRequest)
    }
}
