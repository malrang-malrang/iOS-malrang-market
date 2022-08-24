//
//  Int+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import Foundation

extension Int {
    func formatterString() -> String? {
        return Formatter.number.string(for: self)
    }
}
