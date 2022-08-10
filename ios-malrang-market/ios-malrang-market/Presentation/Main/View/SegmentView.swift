//
//  SegmentView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/10.
//

import UIKit

private enum SegmentType: String, CaseIterable {
    case latelyProduct = "최근 상품"
    case popularProduct = "인기 상품"

    static var value: [String] {
        return Self.allCases.map { $0.rawValue }
    }
}

final class SegmentController: UISegmentedControl {

    init() {
        super.init(items: SegmentType.value)
        self.setupSegmentControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSegmentControl() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setBackgroundImage(
            UIImage(),
            for: .normal,
            barMetrics: .default
        )
        self.setDividerImage(
            UIImage(),
            forLeftSegmentState: .normal,
            rightSegmentState: .normal,
            barMetrics: .default
        )

        let selectedFontColor = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.8737915158, blue: 0.9193537831, alpha: 1)]
        self.setTitleTextAttributes(selectedFontColor, for: .selected)
    }
}
