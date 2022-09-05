//
//  DetailViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

protocol DetailViewCoordinatorProtocol {
    func popDetailView()
    func showActionSheet(actionSheet: UIAlertController)
    func showActivity(activityController: UIActivityViewController)
    func showAlert(alert: UIAlertController)}

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
            useCase: self.useCase
        )
        let detailView = DetailViewController(viewModel: viewModel, coordinator: self)
        self.navigationController.pushViewController(detailView, animated: true)
    }

    func popDetailView() {
        self.navigationController.popViewController(animated: true)
        self.parentCoordinators?.removeChild(self)
    }

    func showActionSheet(actionSheet: UIAlertController) {
        self.navigationController.present(actionSheet, animated: true)
    }

    func showActivity(activityController: UIActivityViewController) {
        self.navigationController.present(activityController, animated: true)
    }

    func showAlert(alert: UIAlertController) {
        self.navigationController.present(alert, animated: true)
    }
}
