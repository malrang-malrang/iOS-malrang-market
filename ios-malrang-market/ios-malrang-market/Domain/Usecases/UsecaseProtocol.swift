//
//  File.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift

protocol UsecaseProtocol {
    func fetchProductCatalog(pageNumber: Int, perPages: Int) -> Observable<ProductCatalog>
    func fetchProductDetail(id: Int) -> Observable<ProductInfomation>
    func post(_ productRequest: ProductRequest) -> Observable<Void>
}

struct DefaultUsecase: UsecaseProtocol {
    private let malrangMarketRepository: MalrangMarketRepositoryProtocol

    init(malrangMarketRepository: MalrangMarketRepositoryProtocol) {
        self.malrangMarketRepository = malrangMarketRepository
    }

    func fetchProductCatalog(pageNumber: Int, perPages: Int) -> Observable<ProductCatalog> {
        return self.malrangMarketRepository.fetchProductList(
            pageNumber: pageNumber,
            perPages: perPages
        )
        .map { $0.toEntity() }
    }

    func fetchProductDetail(id: Int) -> Observable<ProductInfomation> {
        return self.malrangMarketRepository.fetchProductDetail(id: id)
            .compactMap { $0.toEntity() }
    }

    func post(_ productRequest: ProductRequest) -> Observable<Void> {
        return self.malrangMarketRepository.post(product: productRequest)
    }
}
