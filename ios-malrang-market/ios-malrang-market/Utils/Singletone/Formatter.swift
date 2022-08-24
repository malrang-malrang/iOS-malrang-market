//
//  Formatter.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/23.
//

import Foundation

struct Formatter {
    static let date = DateFormatter()
    static let number: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()

    private init() {}
}
