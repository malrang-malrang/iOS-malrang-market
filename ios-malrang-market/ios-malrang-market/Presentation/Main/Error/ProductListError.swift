//
//  ProductListError.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/06.
//

import Foundation

enum ProductListError: Error {
    case hasNextPage

    var errorDescription: String? {
        switch self {
        case .hasNextPage:
            return "다음 페이지 정보가 없습니다."
        }
    }
}
