//
//  ProductDetailRepositoryProtocol.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift

protocol ProductDetailRepositoryProtocol {
    func fetch(endPoint: EndPoint) -> Single<ProductDetail?>
}
