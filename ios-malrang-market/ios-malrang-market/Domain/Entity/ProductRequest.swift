//
//  ProductRequest.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/20.
//

import Foundation

struct ProductRequest: Encodable {
    var boundary: String? = UUID().uuidString
    var pageNumber: Int?
    var perPages: Int?
    var name: String?
    var descriptions: String?
    var price: Double?
    var currency: String?
    var discountedPrice: Double?
    var stock: Int?
    var secret: String?
    var imageInfos: [ImageInfo]?
}

struct ImageInfo: Encodable {
    let fileName: String
    let data: Data
    let type: String
}
