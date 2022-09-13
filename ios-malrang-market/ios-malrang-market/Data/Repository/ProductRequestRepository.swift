//
//  ProductRequestRepository.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/13.
//

//import RxSwift
//
//protocol ProductRequestRepositoryProtocol {
//    func post()
//}
//
//final class ProductRequestRepository: ProductRequestRepositoryProtocol {
//    private let service: Provider
//
//    init(networkProvider: Provider = NetworkProvider()) {
//        self.service = networkProvider
//    }
//
//    func post(_ productRequest: ProductRequest) {
//        let endPoint = EndPointStorage.productPost(body: productRequest).endPoint
//        let result = self.service.requestMultiPartFormData(endPoint: endPoint)
//    }
//
//    func fetch(id: Int) -> Observable<[ProductImages]> {
//        let endPoint = EndPointStorage.productDetail(id: id).endPoint
//        return self.service.request(endPoint: endPoint)
//            .decode(type: ProductDetail.self, decoder: Json.decoder)
//            .compactMap { $0.images }
//    }
//}
