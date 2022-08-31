//
//  MainViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import RxCocoa
import RxRelay

protocol MainViewModelInput {
    func didTapSegmentControl(selected index: Int)
    func cellSelectEvent(selected: ProductDetail)
}

protocol MainViewModelOutput {
    var pageState: BehaviorRelay<Page> { get }
    var recentProducts: Driver<[ProductDetail]> { get }
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    private let useCase: Usecase
    private let coordinator: MainViewCoordinatorProtocol
    private let productsList = BehaviorRelay<[ProductList]>(value: [])
    let pageState = BehaviorRelay<Page>(value: .recentProduct)
    var recentProducts: Driver<[ProductDetail]>

    init(useCase: Usecase, coordinator: MainViewCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator

        self.recentProducts = self.productsList
            .compactMap { $0.last?.pages }
            .asDriver(onErrorJustReturn: [])

        self.fetchRecentProductList(pageNumber: 0, perPages: 20)
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
                self.productsList.accept([productList])
            } onError: { error in
                print(error)
            }
    }

    func cellSelectEvent(selected: ProductDetail) {
        self.coordinator.showDetailView(product: selected)
    }
}
