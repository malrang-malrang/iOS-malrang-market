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

    func fetch(id: Int) -> Observable<[ProductImages]> {
        let endPoint = EndPointStorage.productDetail(id: id).endPoint
        return self.service.request(endPoint: endPoint)
            .decode(type: ProductDetail.self, decoder: Json.decoder)
            .compactMap(\.images)
    }
}
