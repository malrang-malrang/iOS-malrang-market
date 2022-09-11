//
//  MenegementCoordinator.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/11.
//

import UIKit

protocol MenegementCoordinatorProtocol {
    func showRegistrationView()
    func showEditView(_ product: ProductDetail)
    func showPhotoLibrary(_ imagePicker: UIImagePickerController)
    func dismissPhotoLibrary(_ imagePicker: UIImagePickerController)
}

final class MenegementCoordinator: Coordinator, MenegementCoordinatorProtocol {
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
        let registrationView = RegistrationViewController(
            coordinator: self
        )
        self.navigationController.pushViewController(registrationView, animated: true)
    }

    func showEditView(_ product: ProductDetail) {

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
}
