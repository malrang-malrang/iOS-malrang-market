//
//  latelyProductViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/15.
//

import RxCocoa
import RxSwift
import SnapKit

final class RecentProductViewController: UIViewController {
    private let tableView = UITableView()
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
        self.view.addSubviews(self.tableView)
        self.tableView.register(
            RecentProductListCell.self,
            forCellReuseIdentifier: RecentProductListCell.identifier
        )
    }

    private func setupConstraint() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bind() {
        self.viewModel.productList
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

        self.tableView.rx.modelSelected(ProductDetail.self)
            .withUnretained(self)
            .subscribe(onNext: { recentView, product in
                recentView.coordinator.showDetailView(product: product)
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
    }
}
