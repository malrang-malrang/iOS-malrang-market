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
    func fetchFirstPage()
    func fetchNextPage()
    func didTapSegmentControl(selected index: Int)
}

protocol MainViewModelOutput {
    var error: Observable<Error>? { get }
    var currentPageState: Observable<Page> { get }
    var productList: Observable<[ProductDetail]> { get }
    func productDetailList() -> [ProductDetail]
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    private var currentPage = 0
    private var hasNext: Bool?
    private let useCase: Usecase
    var error: Observable<Error>?

    private let pageState = BehaviorRelay<Page>(value: .recentProduct)
    var currentPageState: Observable<Page> {
        return self.pageState.asObservable()
    }

    private let productPage = BehaviorRelay<[ProductDetail]>(value: [])
    var productList: Observable<[ProductDetail]> {
        return productPage.distinctUntilChanged().asObservable()
    }

    init(useCase: Usecase) {
        self.useCase = useCase
        self.hasNext = true
        self.fetchFirstPage()
    }

    func fetchFirstPage() {
        self.currentPage = 1
        _ = self.useCase.fetchProductCatalog(pageNumber: self.currentPage, perPages: 20)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, catalog in
                viewModel.productPage.accept(catalog.0)
                viewModel.hasNext = catalog.1
            }, onError: { error in
                self.error = .just(error)
            })
    }

    func fetchNextPage() {
        guard self.hasNext == true else {
            return self.error = .just(InputError.hasNextPage)
        }
        self.currentPage += 1
        let previousList = self.productPage.value

        _ = self.useCase.fetchProductCatalog(pageNumber: self.currentPage, perPages: 20)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, catalog in
                viewModel.productPage.accept(previousList + catalog.0)
                viewModel.hasNext = catalog.1
            }, onError: { [weak self] error in
                self?.error = .just(error)
            })
    }

    func didTapSegmentControl(selected index: Int) {
        guard let index = Page(rawValue: index) else { return }

        self.pageState.accept(index)
    }

    func productDetailList() -> [ProductDetail] {
        return self.productPage.value
    }
}
