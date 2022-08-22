//
//  ProductListRepositoryProtocol.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/18.
//

import RxSwift

protocol ProductListRepositoryProtocol {
    func fetch(pageNumber: Int, perPages: Int) -> Single<ProductList?>
}
