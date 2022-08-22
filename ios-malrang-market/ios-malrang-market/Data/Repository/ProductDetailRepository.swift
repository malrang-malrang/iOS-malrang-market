//
//  ProductDetailRepository.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/21.
//

import Foundation

import RxSwift

final class ProductDetailRepository: ProductDetailRepositoryProtocol {
    private let service: Provider

    init(networkProvider: Provider = NetworkProvider()) {
        self.service = networkProvider
    }

    func fetch(id: Int) -> Single<ProductDetail?> {
        return Single<ProductDetail?>.create { [weak self] single in
            let endPoint = EndPointStorage.productDetail(id: id).endPoint
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
