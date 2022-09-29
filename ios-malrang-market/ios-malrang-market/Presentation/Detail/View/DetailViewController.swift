//
//  DetailViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxCocoa
import RxSwift
import SnapKit

private enum Const {
    static let editTitle = "상품 정보 수정하기"
    static let activityTitle = "상품 정보 공유하기"
}

final class DetailViewController: UIViewController {
    private let backBarButton: UIBarButtonItem = {
        let bookMarkImage = SystemImage.back
        let barButtonItem = UIBarButtonItem(
            image: bookMarkImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let moreBarButton: UIBarButtonItem = {
        let moreImage = SystemImage.more
        let barButtonItem = UIBarButtonItem(
            image: moreImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private lazy var collectionView: PagingImageCollectionView = {
        let flowLayout = PagingCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(
            width: self.view.bounds.width - 20,
            height: self.view.bounds.height * 0.4
        )

        let collectionView = PagingImageCollectionView(
            viewModel: self.viewModel,
            collectionViewLayout: flowLayout
        )
        return collectionView
    }()

    private let infomationView: DetailInfomationView
    private let viewModel: DetailViewModelable
    private let coordinator: DetailViewCoordinatorProtocol
    private let disposeBag = DisposeBag()

    init(viewModel: DetailViewModelable, coordinator: DetailViewCoordinatorProtocol) {
        self.infomationView = DetailInfomationView(viewModel: viewModel)
        self.coordinator = coordinator
        self.viewModel = viewModel
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
        self.navigationItem.leftBarButtonItem = self.backBarButton
        self.navigationItem.rightBarButtonItem = self.moreBarButton
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(
            self.collectionView,
            self.infomationView
        )
    }

    private func setupConstraint() {
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.45)
        }

        self.infomationView.snp.makeConstraints {
            $0.top.equalTo(self.collectionView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
    }

    private func bind() {
        self.viewModel.error?
            .withUnretained(self)
            .subscribe(onNext: { detailView, error in
                detailView.coordinator.showAlert(title: error.localizedDescription)
            })
            .disposed(by: self.disposeBag)

        self.backBarButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { detailView, _ in
                detailView.coordinator.popDetailView()
            })
            .disposed(by: self.disposeBag)

        self.moreBarButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { detailView, _ in
                guard let product = detailView.viewModel.product else { return }
                detailView.coordinator.showActionSheet(product)
            })
            .disposed(by: self.disposeBag)
    }
}
