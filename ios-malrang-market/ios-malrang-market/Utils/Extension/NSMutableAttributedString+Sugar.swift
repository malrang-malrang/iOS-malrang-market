//
//  NSMutableAttributedString.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/31.
//

import UIKit

extension NSMutableAttributedString {
    convenience init(
        text: String,
        fontWeight: UIFont.Weight,
        letter: String
    ) {
        self.init(string: text)
        let font = UIFont.systemFont(ofSize: 18, weight: fontWeight)
        self.addAttribute(.font, value: font, range: (text as NSString).range(of: letter))
    }
}
