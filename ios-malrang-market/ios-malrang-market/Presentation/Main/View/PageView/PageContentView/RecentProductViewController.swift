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
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            RecentProductListCell.self,
            forCellReuseIdentifier: RecentProductListCell.identifier
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
        self.view.addSubviews(self.tableView)
        self.tableView.delegate = self
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
    }
}

extension RecentProductViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in

                let currentCell = self.tableView.cellForRow(at: indexPath) as? RecentProductListCell
                guard let product = currentCell?.constructedProduct else {
                    return nil
                }

                let shareAction = UIAction(
                    title: "상품 정보 공유하기",
                    image: UIImage(systemName: "square.and.arrow.up")
                ) { _ in
                    self.coordinator.showActivity(product: product)
                }

                let editAction = UIAction(
                    title: "상품 정보 수정하기",
                    image: UIImage(systemName: "square.and.pencil")
                ) { _ in
//                    self.coordinator.showEditView()
                }

                let deleteAction = UIAction(
                    title: "상품 정보 제거하기",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive
                ) { _ in
//                    self.coordinator.delete
                }

                return UIMenu(children: [shareAction, editAction, deleteAction])
            }
    }
}
