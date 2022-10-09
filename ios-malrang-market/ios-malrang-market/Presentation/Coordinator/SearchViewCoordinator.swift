//
//  SearchViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/16.
//

import UIKit

private enum Const {
    static let check = "확인"
    static let emptyString = ""
    static let productInfomationShare = "상품 정보 공유하기"
    static let productInfomationEdit = "상품 정보 수정하기"
    static let productInfomationDelete = "상품 정보 제거하기"
}

protocol SearchViewCoordinatorProtocol {
    func popSearchView()
    func showDetailView(productId: Int)
    func showProductEditView(at productId: Int)
    func contextMenu(at product: ProductInfomation) -> UIContextMenuConfiguration?
}

final class SearchViewCoordinator: Coordinator, SearchViewCoordinatorProtocol {
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

    func start(productList: [ProductInfomation]) {
        let searchViewModel = SearchViewModel(productList: productList)
        let searchView = SearchViewController(viewModel: searchViewModel, coordinator: self)
        self.navigationController.pushViewController(searchView, animated: true)
    }

    func popSearchView() {
        self.navigationController.popViewController(animated: true)
        self.parentCoordinators?.removeChild(self)
    }

    func showDetailView(productId: Int) {
        let detailCoordinator = DetailViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(detailCoordinator)
        detailCoordinator.start(productId: productId)
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

    func contextMenu(at product: ProductInfomation) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in

            let vendorId = Bundle.main.vendorId
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
                guard vendorId == product.vendorId else {
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
                guard vendorId == product.vendorId else {
                    return self.showAlert(
                        title: InputError.productAuthority.errorDescription
                    )
                }
            }

            return UIMenu(children: [shareAction, editAction, deleteAction])
        }
    }

    private func showAlert(title: String) {
        let checkAction = UIAlertAction(title: Const.check, style: .default)
        let alert = AlertBuilder.shared
            .setType(.alert)
            .setTitle(title)
            .setActions([checkAction])
            .build()

        self.navigationController.present(alert, animated: true)
    }

    private func showActivity(product: ProductInfomation) {
        let activity = UIActivityViewController(
            activityItems: [product.name, product.price],
            applicationActivities: nil
        )
        self.navigationController.present(activity, animated: true)
    }
}
