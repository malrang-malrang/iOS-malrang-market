//
//  SegmentView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import Combine
import UIKit

final class SegmentView: UIView {
    private let segmentControl = UnderlineSegmentControl()
    private let viewModel: MainViewModelable
    private var cancellableBag = Set<AnyCancellable>()

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
        NSLayoutConstraint.activate([
            self.segmentControl.topAnchor.constraint(equalTo: self.topAnchor),
            self.segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.segmentControl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.98)
        ])

        NSLayoutConstraint.activate([
            self.underlineView.topAnchor.constraint(equalTo: self.segmentControl.bottomAnchor),
            self.underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func bind() {
        self.viewModel.pageState
            .sink { [weak self] page in
                self?.segmentControl.selectedSegmentIndex = page.value
                self?.segmentControl.changeUnderlinePosition()
            }
            .store(in: &self.cancellableBag)

        self.segmentControl.selectedPublisher
            .sink { [weak self] page in
                self?.viewModel.didTapSegmentControl(selected: page)
            }
            .store(in: &self.cancellableBag)
    }
}
