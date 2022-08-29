//
//  ProductImagesRepository.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/29.
//

import RxSwift

final class ProductImagesRepository: ProductImagesRepositoryProtocol {
    private let service: Provider

    init(networkProvider: Provider = NetworkProvider()) {
        self.service = networkProvider
    }

    func fetch(id: Int) -> Single<[ProductImages]?> {
        return Single<[ProductImages]?>.create { [weak self] single in
            let endPoint = EndPointStorage.productDetail(id: id).endPoint
            _ = self?.service.request(endPoint: endPoint)
                .subscribe { data in
                    let product = self?.decode(data: data)
                    single(.success(product?.images))
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
