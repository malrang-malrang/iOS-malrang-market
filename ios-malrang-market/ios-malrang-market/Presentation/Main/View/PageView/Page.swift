//
//  Page.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import UIKit

enum Page: Int, CaseIterable {
    case recentProduct = 0
    case popularProduct = 1
}

extension Page {
    static var inventory: [String] {
        return Self.allCases.map { $0.description }
    }

    var value: Int {
        return self.rawValue
    }

    private var description: String {
        switch self {
        case .recentProduct:
            return "최근 상품"
        case .popularProduct:
            return "인기 상품"
        }
    }
}
