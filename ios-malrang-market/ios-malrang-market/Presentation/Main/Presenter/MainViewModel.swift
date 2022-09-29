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
    var pageState: Observable<Page> { get }
    var productList: Observable<[ProductInfomation]> { get }
    func productInfomationList() -> [ProductInfomation]
}

protocol MainViewModelable: MainViewModelInput, MainViewModelOutput {}

final class MainViewModel: MainViewModelable {
    private var currentPage = 0
    private var hasNext = false
    private let useCase: UsecaseProtocol
    private let disposeBag = DisposeBag()

    init(useCase: UsecaseProtocol) {
        self.useCase = useCase
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
        guard let index = Page(rawValue: index) else { return }
        self.pageStateRelay.accept(index)
    }

    func productInfomationList() -> [ProductInfomation] {
        return self.productListRelay.value
    }

    // MARK: - Output

    private let errorRelay = PublishRelay<Error>()
    var error: Observable<Error> {
        return self.errorRelay.asObservable()
    }

    private let pageStateRelay = BehaviorRelay<Page>(value: .recentProduct)
    var pageState: Observable<Page> {
        return self.pageStateRelay.asObservable()
    }

    private let productListRelay = BehaviorRelay<[ProductInfomation]>(value: [])
    var productList: Observable<[ProductInfomation]> {
        return productListRelay.distinctUntilChanged().asObservable()
    }
}
