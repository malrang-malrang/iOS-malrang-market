//
//  Notification.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/15.
//

import Foundation

protocol NotificationObservable: AnyObject {}
protocol NotificationPostable: AnyObject {}

extension NotificationObservable {
    func registerNotification(completion: @escaping () -> ()) {
        NotificationCenter.default.addObserver(
            forName: Notification.Name("updateData"),
            object: nil,
            queue: .main
        ) { _ in
            completion()
        }
    }
}

extension NotificationPostable {
    func postNotification() {
        NotificationCenter.default.post(
            name: Notification.Name("updateData"),
            object: nil
        )
    }
}
