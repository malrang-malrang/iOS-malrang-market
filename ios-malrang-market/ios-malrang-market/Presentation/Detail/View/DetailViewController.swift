//
//  DetailViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxCocoa
import RxSwift
import SnapKit

private enum Image {
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let back = UIImage(
        systemName: "arrowshape.turn.up.backward.fill",
        withConfiguration: Atribute.configuration
    )

    static let more = UIImage(
        systemName: "ellipsis",
        withConfiguration: Atribute.configuration
    )
}

final class DetailViewController: UIViewController {
    private let backBarButton: UIBarButtonItem = {
        let bookMarkImage = Image.back
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
        let moreImage = Image.more
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
    private let favoriteButton = FavoriteButton()
    private let viewModel: DetailViewModelable
    private let disposeBag = DisposeBag()

    init(viewModel: DetailViewModelable) {
        self.infomationView = DetailInfomationView(viewModel: viewModel)
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
            self.infomationView,
            self.favoriteButton
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

        self.favoriteButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(15)
        }
    }

    private func bind() {
        self.backBarButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.didTapBackBarButton()
            })
            .disposed(by: self.disposeBag)

        self.favoriteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.favoriteButton.isSelected.toggle()
            })
            .disposed(by: self.disposeBag)

        self.moreBarButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.didTapMoreButton()
            })
            .disposed(by: self.disposeBag)
    }
}
