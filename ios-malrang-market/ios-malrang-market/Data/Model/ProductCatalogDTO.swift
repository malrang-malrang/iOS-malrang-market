//
//  ProductCatalogDTO.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/24.
//

import Foundation

struct ProductCatalogDTO: Decodable {
    let pageNumber: Int?
    let itemsPerPage: Int?
    let totalCount: Int?
    let offset: Int?
    let limit: Int?
    let items: [ProductInfomationDTO]?
    let lastPage: Int?
    let hasNext: Bool?
    let hasPrev: Bool?

    private enum CodingKeys: String, CodingKey {
        case pageNumber = "page_no"
        case itemsPerPage = "items_per_page"
        case totalCount = "total_count"
        case offset
        case limit
        case items = "items"
        case lastPage = "last_page"
        case hasNext = "has_next"
        case hasPrev = "has_prev"
    }
}

extension ProductCatalogDTO {
    func toEntity() -> ProductCatalog {
        return ProductCatalog(
            pageNumber: self.pageNumber ?? .zero,
            itemsPerPage: self.itemsPerPage ?? .zero,
            items: self.items?.compactMap { $0.toEntity() } ?? [],
            hasNextPage: self.hasNext ?? false
        )
    }
}
