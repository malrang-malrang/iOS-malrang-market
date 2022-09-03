//
//  DetailViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

protocol DetailViewCoordinatorProtocol {
    func popDetailView()
    func showActionSheet(actions: [UIAlertAction])
    func showActivity(activityController: UIActivityViewController)
    func showAlert(title: String, message: String, action: UIAlertAction)
}

final class DetailViewCoordinator: Coordinator, DetailViewCoordinatorProtocol, AlertProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: Usecase

    init(
        navigationController: UINavigationController,
        parentCoordinators: Coordinator,
        useCase: Usecase
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinators
        self.useCase = useCase
    }

    func start(product: ProductDetail) {
        let viewModel: DetailViewModelable = DetailViewModel(
            product: product,
            useCase: self.useCase,
            coordinator: self
        )
        let detailView = DetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(detailView, animated: true)
    }

    func popDetailView() {
        self.navigationController.popViewController(animated: true)
        self.parentCoordinators?.removeChild(self)
    }

    func showActionSheet(actions: [UIAlertAction]) {
        let actionSheet = self.makeActionSheet(actions: actions)
        self.navigationController.present(actionSheet, animated: true)
    }

    func showActivity(activityController: UIActivityViewController) {
        self.navigationController.present(activityController, animated: true)
    }

    func showAlert(title: String, message: String, action: UIAlertAction) {
        let alert = self.makeAlert(title: title, message: message, actions: [action])
        self.navigationController.present(alert, animated: true)
    }
}
