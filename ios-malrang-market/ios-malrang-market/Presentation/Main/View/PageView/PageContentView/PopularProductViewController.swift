//
//  PopularProductViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxCocoa
import RxSwift
import SnapKit

final class PopularProductViewController: UIViewController {
    private let viewModel: MainViewModelable
    private let collectionView = UICollectionView()
    private let disposeBag = DisposeBag()

    init(viewModel: MainViewModelable) {
        self.viewModel = viewModel
        super.init()
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
    }

    private func setupConstraint() {
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bind() {

    }
}
