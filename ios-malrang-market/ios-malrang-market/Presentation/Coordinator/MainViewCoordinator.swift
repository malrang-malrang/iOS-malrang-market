//
//  MainViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/07.
//

import UIKit

private enum Const {
    static let check = "확인"
    static let emptyString = ""
    static let productInfomationShare = "상품 정보 공유하기"
    static let productInfomationEdit = "상품 정보 수정하기"
    static let productInfomationDelete = "상품 정보 제거하기"
}

protocol MainViewCoordinatorProtocol {
    func showDetailView(productId: Int?)
    func showProductRegistrationView()
    func showProductEditView(at productId: Int)
    func showSearchView(productList: [ProductInfomation])
    func showAlert(title: String)
    func contextMenu(at product: ProductInfomation) -> UIContextMenuConfiguration?
}

final class MainViewCoordinator: Coordinator, MainViewCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: UsecaseProtocol

    init(
        navigationController: UINavigationController,
        parentCoordinators: Coordinator,
        useCase: UsecaseProtocol
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinators
        self.useCase = useCase
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
        let menegementCoordinator = ManagementViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(menegementCoordinator)
        menegementCoordinator.showRegistrationView()
    }

    func showProductEditView(at productId: Int) {
        let menegementCoordinator = ManagementViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(menegementCoordinator)
        menegementCoordinator.showEditView(at: productId)
    }

    func showSearchView(productList: [ProductInfomation]) {
        let searchCoordinator = SearchViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(searchCoordinator)
        searchCoordinator.start(productList: productList)
    }

    func showAlert(title: String) {
        let checkAction = UIAlertAction(title: Const.check, style: .default)
        let alert = AlertBuilder.shared
            .setType(.alert)
            .setTitle(title)
            .setActions([checkAction])
            .build()

        self.navigationController.present(alert, animated: true)
    }

    func contextMenu(at product: ProductInfomation) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in

            let shareAction = UIAction(
                title: Const.productInfomationShare,
                image: SystemImage.share
            ) { _ in
                self.showActivity(product: product)
            }

            let editAction = UIAction(
                title: Const.productInfomationEdit,
                image: SystemImage.edit
            ) { _ in
                guard UserInfomation.vendotId == product.vendorId else {
                    return self.showAlert(
                        title: InputError.productAuthority.errorDescription
                    )
                }
                self.showProductEditView(at: product.id)
            }

            let deleteAction = UIAction(
                title: Const.productInfomationDelete,
                image: SystemImage.trash,
                attributes: .destructive
            ) { _ in
                guard UserInfomation.vendotId == product.vendorId else {
                    return self.showAlert(
                        title: InputError.productAuthority.errorDescription
                    )
                }
            }

            return UIMenu(children: [shareAction, editAction, deleteAction])
        }
    }

    private func showActivity(product: ProductInfomation) {
        let activity = UIActivityViewController(
            activityItems: [product.name, product.price],
            applicationActivities: nil
        )
        self.navigationController.present(activity, animated: true)
    }
}
