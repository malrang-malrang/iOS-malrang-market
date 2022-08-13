//
//  UnderlineSegmentControl.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/10.
//

import UIKit

enum Page: Int, CaseIterable {
    case latelyProduct = 0
    case popularProduct = 1
}

extension Page {
    static var inventory: [String] {
        return Self.allCases.map { $0.description }
    }

    var value: Int {
        return self.rawValue
    }

    private var description: String {
        switch self {
        case .latelyProduct:
            return "최근 상품"
        case .popularProduct:
            return "인기 상품"
        }
    }
}

final class UnderlineSegmentControl: UISegmentedControl {
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 10.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 5
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        self.addSubview(view)
        return view
    }()

    init() {
        super.init(items: Page.inventory)
        self.setupSegmentControl()
        self.removeBackgroundAndDivider()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSegmentControl() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let selectedFontColor = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)]
        self.setTitleTextAttributes(selectedFontColor, for: .selected)
        let font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }

    private func removeBackgroundAndDivider() {
        self.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        self.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        self.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        self.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }

    func changeUnderlinePosition() {
        let underlineWidth = self.bounds.width / CGFloat(self.numberOfSegments)
        let underlineFinalXPosition = underlineWidth * CGFloat(self.selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            self.underlineView.frame.origin.x = underlineFinalXPosition
            self.layoutIfNeeded()
          })
    }
}
