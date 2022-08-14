//
//  MainViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/03.
//

import UIKit

private enum Const {
    static let searchBarPlaceholder = "말랑마켓 통합검색"
}

private enum Image {
    static let bookmark = "bookmark"
    static let cart = "cart"
}

final class MainViewController: UIViewController {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Const.searchBarPlaceholder
        return searchBar
    }()

    private let bookmarkBarButton: UIBarButtonItem = {
        let configuration = UIImage.SymbolConfiguration(weight: .heavy)
        let bookMarkImage = UIImage(systemName: Image.bookmark, withConfiguration: configuration)
        let barButtonItem = UIBarButtonItem(
            image: bookMarkImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let cartBarButton: UIBarButtonItem = {
        let configuration = UIImage.SymbolConfiguration(weight: .heavy)
        let cartImage = UIImage(systemName: Image.cart, withConfiguration: configuration)
        let barButtonItem = UIBarButtonItem(
            image: cartImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let segmentView: SegmentView
    private let pageContentView: PageContentViewController
    private let addButton: AddProductButton

    init(viewModel: MainViewModelable) {
        self.segmentView = SegmentView(viewModel: viewModel)
        self.pageContentView = PageContentViewController(viewModel: viewModel)
        self.addButton = AddProductButton()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem()
        self.setupView()
        self.setupConstraint()
    }

    private func setupNavigationItem() {
        self.navigationItem.titleView = self.searchBar
        self.navigationItem.rightBarButtonItems = [self.cartBarButton, self.bookmarkBarButton]
    }

    private func setupView() {
        self.addChild(self.pageContentView)
        self.pageContentView.didMove(toParent: self)
        self.view.addSubviews(self.segmentView, self.pageContentView.view, self.addButton)
        self.view.backgroundColor = .systemBackground
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.segmentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.segmentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.segmentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.segmentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06)
        ])

        NSLayoutConstraint.activate([
            self.pageContentView.view.topAnchor.constraint(equalTo: self.segmentView.bottomAnchor),
            self.pageContentView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pageContentView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pageContentView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.addButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.addButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.13),
            self.addButton.heightAnchor.constraint(equalTo: self.addButton.widthAnchor)
        ])
    }
}
