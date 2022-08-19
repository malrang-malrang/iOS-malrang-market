//
//  ProductList.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import Foundation


// 아래가 파싱된애 근데 화면에 아래의 모든정보를 다 보여줄 필요는 없음 그치만 전에 할때는
struct ProductList: Decodable {
    let pageNumber: Int?
    let itemsPerPage: Int?
    let totalCount: Int?
    let offset: Int?
    let limit: Int?
    let pages: [ProductDetail]?
    let lastPage: Int?
    let hasNext: Bool?
    let hasPrev: Bool?
}
