//
//  MainViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/07.
//

import UIKit

protocol MainViewCoordinatorProtocol {
    func showDetailView(product: ProductDetail)
    func showAlert(title: String, message: String, action: UIAlertAction)
}

final class MainViewCoordinator: Coordinator, MainViewCoordinatorProtocol, AlertProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: Usecase = DefaultUsecase(
        listRepository: ProductListRepository(),
        detailRepository: ProductDetailRepository(),
        imagesRepository: ProductImagesRepository()
    )
    private lazy var mainViewModel = MainViewModel(useCase: self.useCase, coordinator: self)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainView = MainViewController(viewModel: mainViewModel)
        self.navigationController.pushViewController(mainView, animated: true)
    }

    func showDetailView(product: ProductDetail) {
        let detailCoordinator = DetailViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(detailCoordinator)
        detailCoordinator.start(product: product)
    }

    func showAlert(title: String, message: String, action: UIAlertAction) {
        let alert = self.makeAlert(title: title, message: message, actions: [action])
        self.navigationController.present(alert, animated: true)
    }
}
