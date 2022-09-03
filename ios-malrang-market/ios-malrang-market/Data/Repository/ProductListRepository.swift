//
//  NetworkRepository.swift
//  ios-malrang-marketTests
//
//  Created by 김동욱 on 2022/08/18.
//

import RxSwift

final class ProductListRepository: ProductListRepositoryProtocol {
    private let service: Provider

    init(networkProvider: Provider = NetworkProvider()) {
        self.service = networkProvider
    }

    func fetch(pageNumber: Int, perPages: Int) -> Observable<ProductList> {
        let endPoint = EndPointStorage.productList(
            pageNumber: pageNumber,
            perPages: perPages
        ).endPoint

        return self.service.request(endPoint: endPoint)
            .decode(type: ProductList.self, decoder: Json.decoder)
    }
}
