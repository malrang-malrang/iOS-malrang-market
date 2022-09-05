//
//  MainViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import RxCocoa
import RxSwift
import RxRelay

protocol MainViewModelInput {
    func didTapSegmentControl(selected index: Int)
}

protocol MainViewModelOutput {
    var currentPageState: Observable<Page> { get }
    var error: Observable<Error>? { get }
    var productList: Observable<[ProductDetail]> { get }
    func fetchNextPage()
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    private var currentPage = 1
    private var hasNext: Bool?
    private let useCase: Usecase
    private let pageState = BehaviorRelay<Page>(value: .recentProduct)
    private let recentProducts = BehaviorRelay<[ProductDetail]>(value: [])

    var error: Observable<Error>?
    var currentPageState: Observable<Page> {
        self.pageState.asObservable()
    }

    var productList: Observable<[ProductDetail]> {
        recentProducts.distinctUntilChanged().asObservable()
    }

    init(useCase: Usecase) {
        self.useCase = useCase
        self.hasNext = true

        self.fetchFirstPage()
    }

    private func fetchFirstPage() {
        self.currentPage = 1
        _ = self.useCase.fetchProductList(pageNumber: self.currentPage, perPages: 20)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, productList in
                viewModel.hasNext = productList.hasNext
                guard let list = productList.pages else { return }
                viewModel.recentProducts.accept(list)
            }, onError: { [weak self] error in
                self?.error = .just(error)
            })
    }

    func fetchNextPage() {
        guard self.hasNext == true else {
            return self.error = .just(ProductListError.hasNextPage)
        }
        self.currentPage += 1
        let previous = self.recentProducts.value

        _ = self.useCase.fetchProductList(pageNumber: self.currentPage, perPages: 20)
            .compactMap { $0.pages }
            .withUnretained(self)
            .subscribe(onNext: { viewModel, productList in
                viewModel.recentProducts.accept(previous + productList)
            })
    }

    func didTapSegmentControl(selected index: Int) {
        guard let index = Page(rawValue: index) else { return }

        self.pageState.accept(index)
    }
}
