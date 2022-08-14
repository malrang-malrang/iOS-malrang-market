//
//  SceneDelegate.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/03.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.coordinator = AppCoordinator(navigationController: navigationController)
        self.coordinator?.start()
        self.window?.makeKeyAndVisible()
    }
}
