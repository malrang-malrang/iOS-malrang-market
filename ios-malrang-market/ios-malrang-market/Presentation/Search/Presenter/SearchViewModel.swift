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
    var searchedProduct: Observable<[ProductDetail]> { get }
}

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput {}

final class SearchViewModel: SearchViewModelable {
    private let productList: [ProductDetail]

    private let searchRelay = BehaviorRelay<[ProductDetail]>(value: [])
    var searchedProduct: Observable<[ProductDetail]> {
        return self.searchRelay.asObservable()
    }

    init(productList: [ProductDetail]) {
        self.productList = productList
    }

    func searchProduct(_ text: String) {
        let filteringProductList = self.productList
            .filter { $0.name?.localizedCaseInsensitiveContains(text) == true }
        self.searchRelay.accept(filteringProductList)
    }
}
