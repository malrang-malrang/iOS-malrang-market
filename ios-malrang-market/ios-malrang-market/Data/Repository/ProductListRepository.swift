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

    func fetch(pageNumber: Int, perPages: Int) -> Single<ProductList?> {
        return Single<ProductList?>.create { [weak self] single in
            let endPoint = EndPointStorage.productList(
                pageNumber: pageNumber,
                perPages: perPages
            ).endPoint
            
            _ = self?.service.request(endPoint: endPoint)
                .subscribe { data in
                    single(.success(self?.decode(data: data)))
                } onFailure: { error in
                    single(.failure(error))
                }
            return Disposables.create()
        }
    }

    private func decode(data: Data) -> ProductList? {
        return try? Json.decoder.decode(ProductList.self, from: data)
    }
}
