//
//  ProductDetailRepository.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/21.
//

import RxSwift

final class ProductDetailRepository: ProductDetailRepositoryProtocol {
    private let service: Provider

    init(networkProvider: Provider = NetworkProvider()) {
        self.service = networkProvider
    }

    func fetch(id: Int) -> Observable<ProductDetail> {
        let endPoint = EndPointStorage.productDetail(id: id).endPoint
        return self.service.request(endPoint: endPoint)
            .decode(type: ProductDetail.self, decoder: Json.decoder)
    }
}
