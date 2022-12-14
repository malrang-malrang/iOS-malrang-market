//
//  ProductListError.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/06.
//

import Foundation

enum InputError: Error {
    case hasNextPage
    case productImage
    case productAuthority

    var errorDescription: String {
        switch self {
        case .hasNextPage:
            return "다음 페이지 정보가 없습니다."
        case .productImage:
            return "상품 이미지를 가져올수 없습니다."
        case .productAuthority:
            return "상품 수정/제거 권한이 없습니다."
        }
    }
}
