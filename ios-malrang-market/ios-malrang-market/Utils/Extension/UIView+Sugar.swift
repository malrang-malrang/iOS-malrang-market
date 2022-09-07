//
//  UIView+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }

    func addInteraction(delegate: UIContextMenuInteractionDelegate) {
        let interaction = UIContextMenuInteraction(delegate: delegate)
        self.addInteraction(interaction)
    }
}
