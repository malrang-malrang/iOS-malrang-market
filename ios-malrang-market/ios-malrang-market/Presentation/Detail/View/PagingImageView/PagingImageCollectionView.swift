//
//  PagingImageCollectionView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/02.
//

import RxCocoa
import RxSwift
import SnapKit

final class PagingImageCollectionView: UICollectionView {
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.6647178156, blue: 0.9059293514, alpha: 1)
        pageControl.numberOfPages = 5
        return pageControl
    }()

    private let viewModel: DetailViewModelable
    private let disposeBag = DisposeBag()

    init(viewModel: DetailViewModelable, collectionViewLayout: UICollectionViewFlowLayout) {
        self.viewModel = viewModel

        super.init(
            frame: CGRect(x: 0, y: 0, width: 0, height: 0),
            collectionViewLayout: collectionViewLayout
        )

        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(self.pageControl)
        self.register(
            ProductImageCell.self,
            forCellWithReuseIdentifier: ProductImageCell.identifier
        )
        self.decelerationRate = .fast
        self.isPagingEnabled = false
    }

    private func setupConstraint() {
        self.pageControl.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(10)
        }
    }

    private func bind() {
        self.viewModel.productImages
            .bind(to: self.rx.items(
                cellIdentifier: ProductImageCell.identifier,
                cellType: ProductImageCell.self
            )) {  _, image, cell in
                cell.configure(image: image)
            }
            .disposed(by: self.disposeBag)
    }
}

extension PagingImageCollectionView: UICollectionViewDelegate {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        self.pageControl.currentPage = page
    }
}
