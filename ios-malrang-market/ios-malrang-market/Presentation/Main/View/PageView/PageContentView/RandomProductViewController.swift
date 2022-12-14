//
//  RandomProductViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift
import SnapKit

private enum Const {
    static let loadingData = "Loading Data"
}

final class RandomProductViewController: UIViewController, NotificationObservable {
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(
            width: self.view.bounds.width * 0.46,
            height: self.view.bounds.height * 0.3
        )

        let collectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: flowLayout
        )

        return collectionView
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
        self.view.addSubviews(self.collectionView)
        self.collectionView.register(
            RandomProductListCell.self,
            forCellWithReuseIdentifier: RandomProductListCell.identifier
        )
        self.collectionView.delegate = self
        self.collectionView.refreshControl = self.refreshControl

    }

    private func setupConstraint() {
        self.collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
    }

    private func setupNotification() {
        self.registerNotification {
            self.pullToRefresh()
        }
    }

    private func bind() {
        self.viewModel.fetch()
            .map { $0.shuffled() }
            .bind(to: self.collectionView.rx.items) { collectionView, row, element in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RandomProductListCell.identifier,
                    for: IndexPath(row: row, section: .zero)
                ) as? RandomProductListCell else {
                    return UICollectionViewCell()
                }
                cell.configure(product: element)

                return cell
            }
            .disposed(by: self.disposeBag)

        self.collectionView.rx.modelSelected(ProductInfomation.self)
            .withUnretained(self)
            .subscribe(onNext: { randomView, product in
                randomView.coordinator.showDetailView(productId: product.id)
            })
            .disposed(by: self.disposeBag)

        self.collectionView.rx.contentOffset
            .filter { $0.y > self.collectionView.contentSize.height * 0.65 }
            .withUnretained(self)
            .subscribe(onNext: { randomView, _ in
                randomView.viewModel.fetchNextPage()
            })
            .disposed(by: self.disposeBag)

        self.refreshControl.rx.controlEvent(.valueChanged)
            .throttle(.seconds(Int(0.5)), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe { recentView, _ in
                recentView.pullToRefresh()
            }
            .disposed(by: self.disposeBag)
    }

    private func pullToRefresh() {
        self.viewModel.fetchFirstPage()
        self.collectionView.refreshControl?.endRefreshing()
    }
}

extension RandomProductViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let currentCell = self.collectionView.cellForItem(at: indexPath) as? RandomProductListCell
        guard let product = currentCell?.constructedProduct else {
            return nil
        }
        return self.coordinator.contextMenu(at: product)
    }
}
