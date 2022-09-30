//
//  ProductDetail.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import UIKit

struct ProductInfomation: Decodable, Equatable {
    static func == (lhs: ProductInfomation, rhs: ProductInfomation) -> Bool {
        lhs.id == rhs.id
    }

    let vendorId: Int
    let id: Int
    let name: String
    let thumbnailImageURLString: String
    let price: Int
    let description: String
    let stock: Int
    let createdAt: String
    let images: [ProductImages]
}
