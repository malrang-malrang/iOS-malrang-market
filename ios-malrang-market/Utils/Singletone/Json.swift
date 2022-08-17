//
//  Json.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import Foundation

struct Json {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private init() {}
}
