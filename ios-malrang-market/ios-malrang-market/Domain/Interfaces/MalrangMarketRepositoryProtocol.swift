//
//  MalrangMarketRepositoryProtocol.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/13.
//

import RxSwift

protocol MalrangMarketRepositoryProtocol {
    func fetchProductList(pageNumber: Int, perPages: Int) -> Observable<ProductCatalogDTO>
    func fetchProductDetail(id: Int) -> Observable<ProductInfomationDTO>
    func post(product: ProductRequest) -> Observable<Void>
}
