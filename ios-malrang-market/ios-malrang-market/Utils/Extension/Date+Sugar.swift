//
//  Date+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import Foundation

extension Date {
    func formatterString() -> String {
        Formatter.date.dateStyle = .long
        return Formatter.date.string(from: self)
    }
}
