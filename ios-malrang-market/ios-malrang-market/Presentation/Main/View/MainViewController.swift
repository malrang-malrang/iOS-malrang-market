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

    private let segmentView = SegmentView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupNavigationItem()
        self.setupConstraint()
    }

    private func setupView() {
        self.view.addSubviews(self.segmentView)
        self.view.backgroundColor = .systemBackground
    }

    private func setupNavigationItem() {
        self.navigationItem.titleView = self.searchBar
        self.navigationItem.rightBarButtonItems = [self.cartBarButton, self.bookmarkBarButton]
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.segmentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.segmentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.segmentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.segmentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06)
        ])
    }
}
