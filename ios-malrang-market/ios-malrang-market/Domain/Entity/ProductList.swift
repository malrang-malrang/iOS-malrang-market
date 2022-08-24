//
//  ProductList.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import Foundation

struct ProductList: Decodable {
    var pageNumber: Int?
    var itemsPerPage: Int?
    var totalCount: Int?
    var offset: Int?
    var limit: Int?
    var pages: [ProductDetail]?
    var lastPage: Int?
    var hasNext: Bool?
    var hasPrev: Bool?
}
