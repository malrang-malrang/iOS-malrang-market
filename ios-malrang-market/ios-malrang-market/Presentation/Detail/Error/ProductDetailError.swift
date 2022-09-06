//
//  ProductDetailError.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/06.
//

import Foundation

enum ProductDetailError: Error {
    case id

    var errorDescription: String? {
        switch self {
        case .id:
            return "상품 아이디가 잘못 되었습니다."
        }
    }
}
