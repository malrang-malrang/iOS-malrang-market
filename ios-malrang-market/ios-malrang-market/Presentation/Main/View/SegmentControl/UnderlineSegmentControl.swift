//
//  UnderlineSegmentControl.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/10.
//

import UIKit

final class UnderlineSegmentControl: UISegmentedControl {
    private let underlineView = UIView()

    init() {
        super.init(items: Page.inventory)
        self.setupSegmentControl()
        self.removeBackgroundAndDivider()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupUnderlineView()
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

    private func setupUnderlineView() {
        let width = self.bounds.size.width / (CGFloat(self.numberOfSegments) * 2)
        let height = 7.0
        let spacer = (self.bounds.size.width / (CGFloat(self.numberOfSegments) * 4))
        let dividePotin = self.bounds.width / CGFloat(self.numberOfSegments)
        let xPosition = CGFloat(self.selectedSegmentIndex) * dividePotin + spacer
        let yPosition = self.bounds.size.height - height
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        self.underlineView.frame = frame
        self.underlineView.backgroundColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        self.underlineView.layer.cornerRadius = 2.5
        self.addSubview(underlineView)
    }

    func changeUnderlinePosition() {
        let spacer = (self.bounds.size.width / (CGFloat(self.numberOfSegments) * 4))
        let dividePotin = self.bounds.width / CGFloat(self.numberOfSegments)
        let xPosition = CGFloat(self.selectedSegmentIndex) * dividePotin + spacer
        UIView.animate(withDuration: 0.1, animations: {
            self.underlineView.frame.origin.x = xPosition
        })
    }
}
