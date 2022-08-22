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
    private let useCase: Usecase
    let pageState = BehaviorRelay<Page>(value: .recentProduct)
    let recentProducts = BehaviorRelay<ProductList>(value: ProductList())

    init(useCase: Usecase) {
        self.useCase = useCase
    }

    func didTapSegmentControl(selected index: Int) {
        guard let index = Page(rawValue: index) else {
            return
        }

        self.pageState.accept(index)
    }

    func fetchRecentProductList(pageNumber: Int, perPages: Int) {
        _ = self.useCase.fetchProductList(pageNumber: pageNumber, perPages: perPages)
            .subscribe { productList in
                guard let recentProducts = productList else {
                    return
                }
                self.recentProducts.accept(recentProducts)
            } onFailure: { error in
                return print(error)
            }
    }
}
