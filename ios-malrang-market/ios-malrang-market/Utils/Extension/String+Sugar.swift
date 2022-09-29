//
//  String+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

extension String {
    func date() -> Date? {
        Formatter.date.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        return Formatter.date.date(from: self)
    }
}
