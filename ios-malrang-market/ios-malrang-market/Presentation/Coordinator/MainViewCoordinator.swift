//
//  MainViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/07.
//

import UIKit

final class MainViewCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    let viewModel = MainViewModel()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainView = MainViewController(viewModel: viewModel)
        self.navigationController.pushViewController(mainView, animated: true)
    }
}
