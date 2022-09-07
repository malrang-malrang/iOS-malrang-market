//
//  AlertBuilder.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/03.
//

import UIKit

final class AlertBuilder {
    struct Product {
        var title: String?
        var message: String?
        var type: UIAlertController.Style = .alert
        var actions: [UIAlertAction] = []
    }

    static private let alertBuilder = AlertBuilder()
    static private var product = Product()

    static var shared: AlertBuilder {
        self.product = Product()
        return alertBuilder
    }

    private init() { }

    func setTitle(_ title: String) -> Self {
        Self.product.title = title

        return self
    }

    func setMessage(_ message: String?) -> Self {
        Self.product.message = message

        return self
    }

    func setType(_ type: UIAlertController.Style) -> Self {
        Self.product.type = type

        return self
    }

    func setActions(_ actions: [UIAlertAction]?) -> Self {
        guard let actions = actions else {
            return self
        }
        
        actions.forEach {
            $0.setValue(#colorLiteral(
                red: 0.9098039269,
                green: 0.4784313738,
                blue: 0.6431372762,
                alpha: 1
            ),
                forKey: "titleTextColor")
            Self.product.actions.append($0)
        }

        return self
    }

    func build() -> UIAlertController {
        let alert = UIAlertController(
            title: AlertBuilder.product.title,
            message: AlertBuilder.product.message,
            preferredStyle: AlertBuilder.product.type
        )

        AlertBuilder.product.actions.forEach {
            alert.addAction($0)
        }

        return alert
    }
}
