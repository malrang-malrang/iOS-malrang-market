//
//  UIView+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/11.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
