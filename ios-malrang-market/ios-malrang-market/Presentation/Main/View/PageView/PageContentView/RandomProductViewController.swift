//
//  RandomProductViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift
import SnapKit

final class RandomProductViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(
            width: self.view.bounds.width * 0.4,
            height: self.view.bounds.height * 0.3
        )

        let collectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: flowLayout
        )
        return collectionView
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
        self.view.addSubviews(self.collectionView)
        self.collectionView.register(
            RandomProductListCell.self,
            forCellWithReuseIdentifier: RandomProductListCell.identifier
        )
    }

    private func setupConstraint() {
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bind() {
        self.viewModel.productList
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

        self.collectionView.rx.contentOffset
            .filter { $0.y > self.collectionView.contentSize.height * 0.65 }
            .withUnretained(self)
            .subscribe(onNext: { recentView, _ in
                recentView.viewModel.fetchNextPage()
            })
            .disposed(by: self.disposeBag)
    }
}
