//
//  AlertProtocol.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/03.
//

import UIKit

protocol AlertProtocol {}

extension AlertProtocol {
    func makeActionSheet(actions: [UIAlertAction]) -> UIAlertController {
        let cancelAction = self.makeAction(title: "확인", style: .cancel)
        return AlertBuilder.shared
            .setType(.actionSheet)
            .setActions([cancelAction] + actions)
            .build()
    }

    func makeAlert(
        title: String,
        message: String? = nil,
        actions: [UIAlertAction]? = nil
    ) -> UIAlertController {
        let cancelAction = self.makeAction(title: "확인", style: .cancel)
        return AlertBuilder.shared
            .setTitle(title)
            .setMessage(message)
            .setType(.alert)
            .setActions([cancelAction])
            .setActions(actions)
            .build()
    }

    func makeAction(
        title: String,
        style: UIAlertAction.Style,
        completionHendler: (() -> Void)? = nil
    ) -> UIAlertAction {
        return UIAlertAction(title: title, style: style) { _ in
            completionHendler?()
        }
    }
}

protocol ActivityProtocol {}

extension ActivityProtocol {
    func makeActivity(_ productInfomation: ProductInfomation) -> UIActivityViewController {
        return UIActivityViewController(
            activityItems: [
                productInfomation.name,
                productInfomation.description,
                productInfomation.price
            ],
            applicationActivities: nil)
    }
}
