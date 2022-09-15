//
//  SearchResultViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/15.
//

import RxSwift

final class SearchResultViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            SearchedProductCell.self,
            forCellReuseIdentifier: SearchedProductCell.identifier
        )
        return tableView
    }()

    private let viewModel: MainViewModelable
    private let coordinator: MainViewCoordinatorProtocol
    private let disposeBag = DisposeBag()

    init(viewModel: MainViewModelable, coordinator: MainViewCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    private func setupView() {
        self.view.addSubview(self.tableView)
    }

    private func setupConstraint() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
            .subscribe(onNext: { recentView, product in
                recentView.coordinator.showDetailView(productId: product.id)
            })
            .disposed(by: self.disposeBag)

        self.tableView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { recentView, indexPath in
                recentView.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}

extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputText = searchController.searchBar.text else {
            return
        }
        self.viewModel.searchProduct(inputText)
    }
}
