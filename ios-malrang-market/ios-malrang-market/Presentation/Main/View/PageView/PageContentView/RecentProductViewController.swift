//
//  latelyProductViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/15.
//

import RxCocoa
import RxSwift
import SnapKit

private enum Const {
    static let loadingData = "Loading Data"
}

final class RecentProductViewController: UIViewController, NotificationObservable {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            RecentProductListCell.self,
            forCellReuseIdentifier: RecentProductListCell.identifier
        )
        return tableView
    }()

    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(
            string: Const.loadingData,
            attributes: [.foregroundColor: #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)]
        )
        return refreshControl
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
        self.setupNotification()
        self.bind()
    }

    private func setupView() {
        self.view.addSubviews(self.tableView)
        self.tableView.delegate = self
        self.tableView.refreshControl = self.refreshControl
    }

    private func setupConstraint() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupNotification() {
        self.registerNotification {
            self.pullToRefresh()
        }
    }

    private func bind() {
        self.viewModel.fetch()
            .bind(to: self.tableView.rx.items) { tableView, row, element in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecentProductListCell.identifier,
                    for: IndexPath(row: row, section: .zero)
                ) as? RecentProductListCell else {
                    return UITableViewCell()
                }
                cell.configure(product: element)

                return cell
            }
            .disposed(by: self.disposeBag)

//        self.viewModel.productList
//            .bind(to: self.tableView.rx.items) { tableView, row, element in
//                guard let cell = tableView.dequeueReusableCell(
//                    withIdentifier: RecentProductListCell.identifier,
//                    for: IndexPath(row: row, section: .zero)
//                ) as? RecentProductListCell else {
//                    return UITableViewCell()
//                }
//                cell.configure(product: element)
//
//                return cell
//            }
//            .disposed(by: self.disposeBag)

        self.tableView.rx.modelSelected(ProductInfomation.self)
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

        self.tableView.rx.contentOffset
            .filter { $0.y > self.tableView.contentSize.height * 0.65 }
            .withUnretained(self)
            .subscribe(onNext: { recentView, _ in
                recentView.viewModel.fetchNextPage()
            })
            .disposed(by: self.disposeBag)

        self.refreshControl.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .subscribe { recentView, _ in
                recentView.pullToRefresh()
            }
            .disposed(by: self.disposeBag)
    }

    private func pullToRefresh() {
        self.viewModel.fetchFirstPage()
        self.tableView.refreshControl?.endRefreshing()
    }
}

extension RecentProductViewController: UITableViewDelegate {
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
