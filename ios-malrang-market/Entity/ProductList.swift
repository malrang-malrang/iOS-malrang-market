//
//  ProductList.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import Foundation

struct ProductList: Decodable {
    let pageNumber: Int?
    let itemsPerPage: Int?
    let totalCount: Int?
    let offset: Int?
    let limit: Int?
    let items: [ProductDetail]?
    let lastPage: Int?
    let hasNext: Bool?
    let hasPrev: Bool?
}
