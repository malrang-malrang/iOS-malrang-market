//
//  DetailViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

final class DetailViewCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    let useCase: Usecase

    init(
        navigationController: UINavigationController,
        parentCoordinators: Coordinator,
        useCase: Usecase
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinators
        self.useCase = useCase
    }

    func start() {
        let detailView = DetailViewController()
        self.navigationController.pushViewController(detailView, animated: true)
    }
}
