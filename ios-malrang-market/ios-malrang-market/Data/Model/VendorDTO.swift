//
//  Vendor.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/24.
//

import Foundation

struct VendorDTO: Decodable {
    let name: String?
    let id: Int?
    let createdAt: String?
    let issuedAt: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case createdAt = "created_at"
        case issuedAt = "issued_at"
    }
}
