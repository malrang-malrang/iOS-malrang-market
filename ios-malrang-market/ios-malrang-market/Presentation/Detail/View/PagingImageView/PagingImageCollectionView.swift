//
//  PagingImageCollectionView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/02.
//

import RxCocoa
import RxSwift

final class PagingImageCollectionView: UICollectionView {
    private let viewModel: DetailViewModelable
    private let disposeBag = DisposeBag()

    init(viewModel: DetailViewModelable, collectionViewLayout: UICollectionViewFlowLayout) {
        self.viewModel = viewModel
        super.init(
            frame: CGRect(x: 0, y: 0, width: 0, height: 0),
            collectionViewLayout: collectionViewLayout
        )
        self.setupView()
        self.bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.register(
            ProductImageCell.self,
            forCellWithReuseIdentifier: ProductImageCell.identifier
        )
        self.decelerationRate = .fast
        self.isPagingEnabled = false
    }

    private func bind() {
        self.viewModel.imageString
            .bind(to: self.rx.items(
                cellIdentifier: ProductImageCell.identifier,
                cellType: ProductImageCell.self
            )) {  _, urlString, cell in
                cell.configure(image: urlString.image())
            }
            .disposed(by: self.disposeBag)
    }
}
