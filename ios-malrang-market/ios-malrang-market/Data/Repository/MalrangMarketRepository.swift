//
//  ProductDetailRepository.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/21.
//

import RxSwift

final class MalrangMarketRepository: MalrangMarketRepositoryProtocol {
    private let service: Provider

    init(networkProvider: Provider = NetworkProvider()) {
        self.service = networkProvider
    }

    func fetchProductList(pageNumber: Int, perPages: Int) -> Observable<ProductCatalogDTO> {
        let endPoint = EndPointStorage.productList(
            pageNumber: pageNumber,
            perPages: perPages
        ).endPoint

        return self.service.request(endPoint: endPoint)
            .decode(type: ProductCatalogDTO.self, decoder: Json.decoder)
    }

    func fetchProductDetail(id: Int) -> Observable<ProductInfomationDTO> {
        let endPoint = EndPointStorage.productDetail(id: id).endPoint
        return self.service.request(endPoint: endPoint)
            .decode(type: ProductInfomationDTO.self, decoder: Json.decoder)
    }

    func post(product: ProductRequest) -> Observable<Void> {
        let endPoint = EndPointStorage.productPost(body: product).endPoint
        return self.service.requestMultiPartFormData(endPoint: endPoint)
            .map { _ in }
    }
}
