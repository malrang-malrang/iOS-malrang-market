//
//  ProductSearchControl.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/15.
//

import RxSwift

private enum Const {
    static let searchBarPlaceholder = "말랑마켓 상품검색"
}

final class ProductSearchControl: UISearchController {
    init(viewModel: MainViewModelable, coordinator: MainViewCoordinatorProtocol) {
        let searchResultViewController = SearchResultViewController(
            viewModel: viewModel,
            coordinator: coordinator
        )
        super.init(searchResultsController: searchResultViewController)
        self.searchResultsUpdater = searchResultViewController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    private func setupView() {
        self.searchBar.placeholder = Const.searchBarPlaceholder
    }
}
