//
//  ProductInfomationDTO.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/24.
//

import Foundation

struct ProductInfomationDTO: Decodable {
    let id: Int?
    let vendorID: Int?
    let name: String?
    let thumbnail: String?
    let currency: String?
    let price: Int?
    let description: String?
    let bargainPrice: Double?
    let discountedPrice: Double?
    let stock: Int?
    let createdAt: String?
    let issuedAt: String?
    let imageInfos: [ProductImagesDTO]?
    let vendor: VendorDTO?

    private enum CodingKeys: String, CodingKey {
        case id
        case vendorID = "vendor_id"
        case name
        case thumbnail
        case currency
        case price
        case description
        case bargainPrice = "bargain_price"
        case discountedPrice = "discounted_price"
        case stock
        case createdAt = "created_at"
        case issuedAt = "issued_at"
        case imageInfos = "images"
        case vendor = "vendors"
    }
}

extension ProductInfomationDTO {
    func toEntity() -> ProductInfomation? {
        guard let vendorID = self.vendorID,
              let id = self.id,
              let name = self.name,
              let thumbnail = self.thumbnail,
              let price = self.price,
              let description = self.description,
              let stock = self.stock,
              let createdAt = self.createdAt,
              let images = self.imageInfos
        else {
            return nil
        }

        return ProductInfomation(
            vendorId: vendorID,
            id: id,
            name: name,
            thumbnailImageURLString: thumbnail,
            price: price,
            description: description,
            stock: stock,
            createdAt: createdAt,
            images: images.compactMap { $0.toEntity() }
        )
    }
}
