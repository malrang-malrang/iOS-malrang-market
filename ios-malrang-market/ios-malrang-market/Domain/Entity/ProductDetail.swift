//
//  ProductDetail.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import UIKit

struct ProductDetail: Decodable {
    let id: Int?
    let vendorId: Int?
    let name: String?
    let thumbnail: String?
    let currency: String?
    let price: Int?
    let description: String?
    let bargainPrice: Int?
    let discountedPrice: Int?
    let stock: Int?
    let createdAt: String?
    let issuedAt: String?
    let images: [ProductImages]?
    let favorite: Bool?
}

struct ProductImages: Codable {
    let id: Int?
    let url: String?
    let thumbnailUrl: String?
    let succeed: Bool?
    let issuedAt: String?
}
