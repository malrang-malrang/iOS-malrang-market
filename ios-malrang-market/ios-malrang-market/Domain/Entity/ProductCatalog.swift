//
//  ProductCatalog.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import Foundation

struct ProductCatalog: Decodable {
    let pageNumber: Int
    let itemsPerPage: Int
    let items: [ProductInfomation]
    let hasNextPage: Bool
}
