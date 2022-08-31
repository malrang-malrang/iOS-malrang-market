//
//  ProductDetail.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import Foundation

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
}

struct ProductImages: Codable {
    let id: Int?
    let url: String?
    let thumbnailUrl: String?
    let succeed: Bool?
    let issuedAt: String?
}

extension ProductDetail {
    func createdAtString() -> String {
        guard let createdAt = self.createdAt?.date()?.formatterString() else {
            return ""
        }
        return createdAt
    }

    func priceString() -> String? {
        guard let price = self.price?.formatterString() else {
            return ""
        }
        return "\(price)원"
    }

    func stockString() -> String {
        guard let stock = self.stock?.formatterString() else {
            return ""
        }
        return "현재 재고는 \(stock)개 남아있습니다."
    }
}
