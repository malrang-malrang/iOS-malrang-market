//
//  DetailViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

protocol DetailViewCoordinatorProtocol {
    func popDetailView()
}

final class DetailViewCoordinator: Coordinator, DetailViewCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: Usecase
    private lazy var viewModel: DetailViewModelable = DetailViewModel(coordinator: self)

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
        let detailView = DetailViewController(viewModel: self.viewModel)
        self.navigationController.pushViewController(detailView, animated: true)
    }

    func popDetailView() {
//        guard let detailView = self.navigationController.viewControllers.last else {
//            return
//        }
        self.navigationController.popViewController(animated: true)
        self.parentCoordinators?.removeChild(self)
    }
}
