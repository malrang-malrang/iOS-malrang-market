//
//  ManagementViewCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/11.
//

import UIKit

protocol ManagementViewCoordinatorProtocol {
    func showRegistrationView()
    func showEditView(at productId: Int)
    func popMenegementView()
    func showPhotoLibrary(_ imagePicker: UIImagePickerController)
    func dismissPhotoLibrary(_ imagePicker: UIImagePickerController)
    func showAlert(title: String)
}

final class ManagementViewCoordinator: Coordinator, ManagementViewCoordinatorProtocol {
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

    func showRegistrationView() {
        let viewModel = ManagementViewModel(useCase: self.useCase)
        let registrationView = RegistrationViewController(
            viewModel: viewModel,
            coordinator: self
        )
        self.navigationController.pushViewController(registrationView, animated: true)
    }

    func showEditView(at productId: Int) {
        let viewModel = ManagementViewModel(productId: productId, useCase: self.useCase)
        let editView = EditViewController(
            viewModel: viewModel,
            coordinator: self
        )
        self.navigationController.pushViewController(editView, animated: true)
    }

    func showPhotoLibrary(_ imagePicker: UIImagePickerController) {
        self.navigationController.present(imagePicker, animated: true)
    }

    func dismissPhotoLibrary(_ imagePicker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }

    func popMenegementView() {
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
}
