//
//  UIStackView+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ view: UIView...) {
        view.forEach {
            self.addArrangedSubview($0)
        }
    }
}
