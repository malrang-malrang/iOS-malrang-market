//
//  ProductListError.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/06.
//

import Foundation

enum ProductError: Error {
    case hasNextPage
    case productId

    var errorDescription: String? {
        switch self {
        case .hasNextPage:
            return "다음 페이지 정보가 없습니다."
        case .productId:
            return "상품 아이디가 잘못 되었습니다."
        }
    }
}
