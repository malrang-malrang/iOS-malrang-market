//
//  MainViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import RxRelay

enum MainViewModelState {
    case selectedSegment(type: Page)
}

protocol MainViewModelInput {
    func didTapSegmentControl(selected index: Int)
}

protocol MainViewModelOutput {
    var pageState: BehaviorRelay<Page> { get }
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    let pageState = BehaviorRelay<Page>(value: .latelyProduct)

    func didTapSegmentControl(selected index: Int) {
        guard let index = Page(rawValue: index) else {
            return
        }

        self.pageState.accept(index)
    }
}
