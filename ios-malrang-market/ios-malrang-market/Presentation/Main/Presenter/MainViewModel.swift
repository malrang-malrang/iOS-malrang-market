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
    var error: Observable<Error> { get }
    var currentPageState: Observable<Page> { get }
    var productList: Observable<[ProductInfomation]> { get }
    func productInfomationList() -> [ProductInfomation]
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    private var currentPage = 0
    private var hasNext: Bool?
    private let useCase: UsecaseProtocol

    private let errorRelay = PublishRelay<Error>()
    var error: Observable<Error> {
        return self.errorRelay.asObservable()
    }

    private let pageState = BehaviorRelay<Page>(value: .recentProduct)
    var currentPageState: Observable<Page> {
        return self.pageState.asObservable()
    }

    private let productPage = BehaviorRelay<[ProductInfomation]>(value: [])
    var productList: Observable<[ProductInfomation]> {
        return productPage.distinctUntilChanged().asObservable()
    }

    init(useCase: UsecaseProtocol) {
        self.useCase = useCase
        self.hasNext = true
    }

    func fetchFirstPage() {
        self.currentPage = 1
        _ = self.useCase.fetchProductCatalog(pageNumber: self.currentPage, perPages: 20)
            .subscribe(onNext: { catalog in
                self.productPage.accept(catalog.items)
                self.hasNext = catalog.hasNextPage
            }, onError: { error in
                self.errorRelay.accept(error)
            })
    }

    func fetchNextPage() {
        guard self.hasNext == true else {
            return self.errorRelay.accept(InputError.hasNextPage)
        }
        self.currentPage += 1
        let previousPageItems = self.productPage.value

        _ = self.useCase.fetchProductCatalog(pageNumber: self.currentPage, perPages: 20)
            .subscribe(onNext: { catalog in
                self.productPage.accept(previousPageItems + catalog.items)
                self.hasNext = catalog.hasNextPage
            }, onError: { error in
                self.errorRelay.accept(error)
            })
    }

    func didTapSegmentControl(selected index: Int) {
        guard let index = Page(rawValue: index) else { return }
        self.pageState.accept(index)
    }

    func productInfomationList() -> [ProductInfomation] {
        return self.productPage.value
    }
}
