//
//  MainViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import RxSwift
import RxRelay
import RxCocoa

protocol MainViewModelInput {
    func fetchFirstPage()
    func fetchNextPage()
    func didTapSegmentControl(selected index: Int)
}

protocol MainViewModelOutput {
    var error: Observable<Error> { get }
    var pageState: Observable<Page> { get }
    var productList: Observable<[ProductInfomation]> { get }
    func productInfomationList() -> [ProductInfomation]
    func fetch() -> Observable<[ProductInfomation]>
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    private let errorRelay = ReplayRelay<Error>.create(bufferSize: 1)
    private let pageStateRelay = BehaviorRelay<Page>(value: .recentProduct)
    private let productListRelay = BehaviorRelay<[ProductInfomation]>(value: [])
    private var currentPage = 0
    private var hasNext = false
    private let useCase: UsecaseProtocol
    private let disposeBag = DisposeBag()

    init(useCase: UsecaseProtocol) {
        self.useCase = useCase
        self.fetchFirstPage()
    }

    // MARK: - Input

    func fetchFirstPage() {
        self.useCase.fetchProductCatalog(pageNumber: self.currentPage, perPages: 20)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, catalog in
                viewModel.currentPage = catalog.pageNumber
                viewModel.productListRelay.accept(catalog.items)
                viewModel.hasNext = catalog.hasNextPage
            }, onError: { error in
                self.errorRelay.accept(error)
            })
            .disposed(by: self.disposeBag)
    }

    func fetchNextPage() {
        guard self.hasNext == true else {
            return self.errorRelay.accept(InputError.hasNextPage)
        }

        self.useCase.fetchProductCatalog(pageNumber: self.currentPage + 1, perPages: 20)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, catalog in
                viewModel.currentPage = catalog.pageNumber
                viewModel.productListRelay.accept(self.productListRelay.value + catalog.items)
                viewModel.hasNext = catalog.hasNextPage
            }, onError: { error in
                self.errorRelay.accept(error)
            })
            .disposed(by: self.disposeBag)
    }

    func didTapSegmentControl(selected index: Int) {
        guard let page = Page(rawValue: index) else { return }
        self.pageStateRelay.accept(page)
    }

    // MARK: - Output

    var error: Observable<Error> {
        return self.errorRelay.asObservable()
    }

    var pageState: Observable<Page> {
        return self.pageStateRelay.asObservable()
    }

    var productList: Observable<[ProductInfomation]> {
        return productListRelay.distinctUntilChanged().asObservable()
    }

    func productInfomationList() -> [ProductInfomation] {
        return self.productListRelay.value
    }

    func fetch() -> Observable<[ProductInfomation]> {
        return self.useCase.fetchProductCatalog(pageNumber: 0, perPages: 20)
            .do { catalog in
                self.hasNext = catalog.hasNextPage
                self.currentPage = catalog.pageNumber
            }
            .map { $0.items }
            .catch({ error in
                self.errorRelay.accept(error)
                return Observable.just([])
            })
            .share()
    }
}
