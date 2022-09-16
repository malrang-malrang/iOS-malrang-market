//
//  SearchViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/16.
//

import RxSwift

private enum Const {
    static let searchProduct = "상품을 검색해주세요."
}

final class SearchViewController: UIViewController {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Const.searchProduct
        return searchBar
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            SearchedProductCell.self,
            forCellReuseIdentifier: SearchedProductCell.identifier
        )
        return tableView
    }()

    private let viewModel: SearchViewModelable
    private let coordinator: SearchViewCoordinatorProtocol
    private let disposeBag = DisposeBag()

    init(viewModel: SearchViewModelable, coordinator: SearchViewCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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
        self.bind()
    }

    private func setupNavigationItem() {
        self.navigationItem.titleView = self.searchBar
    }

    private func setupView() {
        self.view.addSubview(self.tableView)
        self.view.backgroundColor = .systemBackground
        self.searchBar.delegate = self
        self.searchBar.becomeFirstResponder()
        self.tableView.delegate = self
    }

    private func setupConstraint() {
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }

    private func bind() {
        self.viewModel.searchedProduct
            .bind(to: self.tableView.rx.items) { tableView, row, element in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchedProductCell.identifier,
                    for: IndexPath(row: row, section: .zero)
                ) as? SearchedProductCell else {
                    return UITableViewCell()
                }
                cell.configure(product: element)

                return cell
            }
            .disposed(by: self.disposeBag)

        self.tableView.rx.modelSelected(ProductDetail.self)
            .withUnretained(self)
            .subscribe(onNext: { searchView, product in
                searchView.coordinator.showDetailView(productId: product.id)
            })
            .disposed(by: self.disposeBag)

        self.tableView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { searchView, indexPath in
                searchView.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchProduct(searchText)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {

        let currentCell = self.tableView.cellForRow(at: indexPath) as? RecentProductListCell
        guard let product = currentCell?.constructedProduct else {
            return nil
        }
        return self.coordinator.contextMenu(at: product)
    }
}
