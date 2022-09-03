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
        let sheet = AlertBuilder.shared
            .setType(.actionSheet)
            .setActions(actions)
            .build()

        return sheet
    }

    func makeAlert(
        title: String,
        message: String? = nil,
        actions: [UIAlertAction]? = nil
    ) -> UIAlertController {
        let alert = AlertBuilder.shared
            .setTitle(title)
            .setMessage(message)
            .setType(.alert)
            .setActions(actions)
            .build()

        return alert
    }
}
