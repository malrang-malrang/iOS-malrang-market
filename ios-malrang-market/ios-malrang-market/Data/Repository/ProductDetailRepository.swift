//
//  ProductDetailRepository.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/21.
//

import Foundation

import RxSwift

final class ProjectDetailRepository: ProductDetailRepositoryProtocol {
    private let service: Provider

    init(networkProvider: Provider = NetworkProvider()) {
        self.service = networkProvider
    }

    func fetch(endPoint: EndPoint) -> Single<ProductDetail?> {
        return Single<ProductDetail?>.create { [weak self] single in
            _ = self?.service.request(endPoint: endPoint)
                .subscribe { data in
                    single(.success(self?.decode(data: data)))
                } onFailure: { error in
                    single(.failure(error))
                }
            return Disposables.create()
        }
    }

    private func decode(data: Data) -> ProductDetail? {
        return try? Json.decoder.decode(ProductDetail.self, from: data)
    }
}
