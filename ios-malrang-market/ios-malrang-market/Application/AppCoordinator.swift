//
//  AppCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/07.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinators: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    func removeChild(_ coordinator: Coordinator) {
        self.childCoordinators.removeAll()
    }
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainCoordinator = MainViewCoordinator(navigationController: self.navigationController)
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.parentCoordinators = self
        mainCoordinator.start()
    }
}
