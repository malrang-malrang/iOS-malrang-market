//
//  SegmentView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import UIKit

final class SegmentView: UIView {
    private var segmentController = SegmentController()

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: CGRect())
        self.setupView()
        self.setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        self.addSubViews(self.segmentController, self.underlineView)
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.segmentController.topAnchor.constraint(equalTo: self.topAnchor),
            self.segmentController.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.segmentController.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.segmentController.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.98)
        ])

        NSLayoutConstraint.activate([
            self.underlineView.topAnchor.constraint(equalTo: self.segmentController.bottomAnchor),
            self.underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
