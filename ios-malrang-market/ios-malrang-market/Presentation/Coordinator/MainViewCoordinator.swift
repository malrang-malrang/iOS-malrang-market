//
//  MainViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/07.
//

import UIKit

protocol MainViewCoordinatorProtocol {
    func showDetailView(product: ProductDetail)
    func showProductRegistrationView()
    func showAlert(title: String)
    func showActivity(product: ProductDetail)
}

final class MainViewCoordinator: Coordinator, MainViewCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: Usecase = DefaultUsecase(
        listRepository: ProductListRepository(),
        detailRepository: ProductDetailRepository(),
        imagesRepository: ProductImagesRepository()
    )

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewModel = MainViewModel(useCase: self.useCase)
        let mainView = MainViewController(viewModel: mainViewModel, coordinator: self)
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

    func showProductRegistrationView() {
        let menegementCoordinator = MenegementCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(menegementCoordinator)
        menegementCoordinator.showRegistrationView()
    }

    func showProductEditView(_ product: ProductDetail) {
        let menegementCoordinator = MenegementCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(menegementCoordinator)
        menegementCoordinator.showEditView(product)
    }

    func showAlert(title: String) {
        let alert = AlertBuilder.shared
            .setType(.alert)
            .setTitle(title)
            .build()
        self.navigationController.present(alert, animated: true)
    }

    func showActivity(product: ProductDetail) {
        let activity = UIActivityViewController(
            activityItems: [product.name ?? "", product.price ?? ""],
            applicationActivities: nil
        )
        self.navigationController.present(activity, animated: true)
    }
}
