//
//  MainViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import Combine

enum MainViewModelState {
    case selectedSegment(type: Page)
}

protocol MainViewModelInput {
    func didTapSegmentControl(selected page: Page)
}

protocol MainViewModelOutput {
    var pageState: CurrentValueSubject<Page, Never> { get }
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    let pageState = CurrentValueSubject<Page, Never>(.latelyProduct)

    func didTapSegmentControl(selected page: Page) {
        self.pageState.send(page)
    }
}
