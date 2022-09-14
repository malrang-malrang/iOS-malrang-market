//
//  MainViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/07.
//

import UIKit

protocol MainViewCoordinatorProtocol {
    func showDetailView(productId: Int?)
    func showProductRegistrationView()
    func showProductEditView(at productId: Int)
    func showAlert(title: String)
    func showActivity(product: ProductDetail)
}

final class MainViewCoordinator: Coordinator, MainViewCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: Usecase = DefaultUsecase(
        malrangMarketRepository: MalrangMarketRepository()
    )

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewModel = MainViewModel(useCase: self.useCase)
        let mainView = MainViewController(viewModel: mainViewModel, coordinator: self)
        self.navigationController.pushViewController(mainView, animated: true)
    }

    func showDetailView(productId: Int?) {
        let detailCoordinator = DetailViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(detailCoordinator)
        detailCoordinator.start(productId: productId)
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

    func showProductEditView(at productId: Int) {
        let menegementCoordinator = MenegementCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(menegementCoordinator)
        menegementCoordinator.showEditView(at: productId)
    }

    func showAlert(title: String) {
        let checkAction = UIAlertAction(title: "확인", style: .default)
        let alert = AlertBuilder.shared
            .setType(.alert)
            .setTitle(title)
            .setActions([checkAction])
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
