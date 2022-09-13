//
//  MalrangMarketRepositoryProtocol.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/13.
//

import RxSwift

protocol MalrangMarketRepositoryProtocol {
    func fetchProductList(pageNumber: Int, perPages: Int) -> Observable<ProductList>
    func fetchProductDetail(id: Int) -> Observable<ProductDetail>
    func post(product: ProductRequest) -> Observable<Void>
}
