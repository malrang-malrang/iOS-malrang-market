//
//  SegmentView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import RxCocoa
import RxSwift
import SnapKit

final class SegmentView: UIView {
    private let segmentControl = UnderlineSegmentControl()
    private let viewModel: MainViewModelable
    private var disposeBag = DisposeBag()

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: MainViewModelable) {
        self.viewModel = viewModel
        super.init(frame: CGRect())
        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        self.addSubviews(self.segmentControl, self.underlineView)
    }

    private func setupConstraint() {
        self.segmentControl.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.98)
        }

        self.underlineView.snp.makeConstraints {
            $0.top.equalTo(self.segmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func bind() {
        self.viewModel.pageState
            .subscribe(onNext: { [weak self] page in
                self?.segmentControl.selectedSegmentIndex = page.value
                self?.segmentControl.changeUnderlinePosition()
            })
            .disposed(by: self.disposeBag)

        self.segmentControl.rx.value
            .bind(onNext: { [weak self] index in
                self?.viewModel.didTapSegmentControl(selected: index)
                self?.segmentControl.changeUnderlinePosition()
            })
            .disposed(by: self.disposeBag)
    }
}
