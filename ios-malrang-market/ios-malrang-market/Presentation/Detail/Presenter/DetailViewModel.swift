//
//  DetailViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import Foundation

enum DetailViewModelState {
}

protocol DetailViewModelInput {
    func didTapBackBarButton()
}

protocol DetailViewModelOutput {

}

protocol DetailViewModelable: DetailViewModelInput, DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelable {
    private let coordinator: DetailViewCoordinatorProtocol

    init(coordinator: DetailViewCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func didTapBackBarButton() {
        self.coordinator.popDetailView()
    }
}
