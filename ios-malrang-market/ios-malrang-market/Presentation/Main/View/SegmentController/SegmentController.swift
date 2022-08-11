//
//  SegmentController.swift
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
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 10.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 5
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8737915158, blue: 0.9193537831, alpha: 1)
        self.addSubview(view)
        return view
    }()

    init() {
        super.init(items: SegmentType.value)
        self.setupSegmentControl()
        self.removeBackgroundAndDivider()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSegmentControl() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectedSegmentIndex = 0
        let selectedFontColor = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.8737915158, blue: 0.9193537831, alpha: 1)]
        self.setTitleTextAttributes(selectedFontColor, for: .selected)
    }

    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.changeUnderlinePosition()
      }

    private func changeUnderlinePosition() {
        let underlineWidth = self.bounds.width / CGFloat(self.numberOfSegments)
        let underlineFinalXPosition = underlineWidth * CGFloat(self.selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            self.underlineView.frame.origin.x = underlineFinalXPosition
          })
    }
}
