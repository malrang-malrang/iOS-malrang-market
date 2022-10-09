//
//  HTTPMethod.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/16.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"

    var value: String {
        return self.rawValue
    }
}
