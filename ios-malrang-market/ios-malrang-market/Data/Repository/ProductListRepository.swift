//
//  NetworkRepository.swift
//  ios-malrang-marketTests
//
//  Created by 김동욱 on 2022/08/18.
//

import Foundation

import RxSwift

final class ProductListRepository: Repositoryable {
    private let service: Provider

    init(networkProvider: Provider = NetworkProvider()) {
        self.service = networkProvider
    }

    func fetch(endPoint: EndPoint) -> Single<ProductList?> {
        return Single<ProductList?>.create { [weak self] single in
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
