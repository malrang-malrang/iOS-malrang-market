//
//  DetailViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

protocol DetailViewCoordinatorProtocol {
    func popDetailView()
    func showActionSheet(_ product: ProductDetail)
    func showAlert(title: String)
}

final class DetailViewCoordinator: Coordinator, DetailViewCoordinatorProtocol {
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

    func start(productId: Int?) {
        let viewModel: DetailViewModelable = DetailViewModel(
            productId: productId,
            useCase: self.useCase
        )
        let detailView = DetailViewController(viewModel: viewModel, coordinator: self)
        self.navigationController.pushViewController(detailView, animated: true)
    }

    func popDetailView() {
        self.navigationController.popViewController(animated: true)
        self.parentCoordinators?.removeChild(self)
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

    func showActionSheet(_ product: ProductDetail) {
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        let editAction = UIAlertAction(
            title: "상품 정보 수정하기",
            style: .default) { _ in
                guard UserInfomation.vendotId == product.vendorId else {
                    return self.showAlert(
                        title: InputError.productAuthority.errorDescription
                    )
                }
                self.showProductEditView(at: product.id ?? 0)
            }

        let deleteAction = UIAlertAction(
            title: "상품 정보 제거하기",
            style: .default) { _ in
                guard UserInfomation.vendotId == product.vendorId else {
                    return self.showAlert(
                        title: InputError.productAuthority.errorDescription
                    )
                }
            }

        let activityAction = UIAlertAction(
            title: "상품 정보 공유하기",
            style: .default) { _ in
                let activity = UIActivityViewController(
                    activityItems: [product.name ?? "", product.price ?? ""],
                    applicationActivities: nil
                )
                self.navigationController.present(activity, animated: true)
            }

        let actionSheet = AlertBuilder.shared
            .setType(.actionSheet)
            .setActions([cancelAction, editAction, deleteAction, activityAction])
            .build()

        self.navigationController.present(actionSheet, animated: true)
    }

    private func showProductEditView(at productId: Int) {
        let managementCoordinator = ManagementViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            useCase: self.useCase
        )
        self.childCoordinators.append(managementCoordinator)
        managementCoordinator.showEditView(at: productId)
    }
}
