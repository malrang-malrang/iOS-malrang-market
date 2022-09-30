//
//  MainViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/15.
//

import RxCocoa
import RxSwift
import RxRelay

protocol SearchViewModelInput {
    func searchProduct(_ text: String)
}

protocol SearchViewModelOutput {
    var searchedProduct: Observable<[ProductInfomation]> { get }
}

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput {}

final class SearchViewModel: SearchViewModelable {
    private let productList: [ProductInfomation]
    private let searchRelay = PublishRelay<[ProductInfomation]>()

    init(productList: [ProductInfomation]) {
        self.productList = productList
    }

    // MARK: - Input

    func searchProduct(_ text: String) {
        let filteringProductList = self.productList
            .filter { $0.name.localizedCaseInsensitiveContains(text) == true }
        self.searchRelay.accept(filteringProductList)
    }

    // MARK: - Output

    var searchedProduct: Observable<[ProductInfomation]> {
        return self.searchRelay.asObservable()
    }
}
