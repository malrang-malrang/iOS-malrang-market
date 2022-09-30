//
//  ProductImages.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/24.
//

import Foundation

struct ProductImagesDTO: Decodable {
    let id: Int?
    let url: String?
    let thumbnailURL: String?
    let isSuccess: Bool?
    let issuedAt: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case url
        case thumbnailURL = "thumbnail_url"
        case isSuccess = "succeed"
        case issuedAt = "issued_at"
    }
}

extension ProductImagesDTO {
    func toEntity() -> ProductImages? {
        guard let id = id,
              let url = self.url,
              let thumbnailURL = self.thumbnailURL
        else {
            return nil
        }

        return ProductImages(
            id: id,
            url: url,
            thumbnailURL: thumbnailURL
        )
    }
}
