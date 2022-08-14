//
//  addView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/14.
//

import UIKit

final class AddProductButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.didTapButtonAnimation()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        self.drawCircle()
        self.drawAddLine()
    }

    private func setupButton() {
        self.backgroundColor = .systemBackground
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func drawCircle() {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let height = bounds.height
        let width = bounds.width

        context.setLineCap(.round)
        context.setFillColor(#colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1))
        let circle = bounds.insetBy(dx: width * 0.05, dy: height * 0.05)
        context.addEllipse(in: circle)
        context.fillPath()
    }

    private func drawAddLine() {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let height = bounds.height
        let width = bounds.width

        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(3)
        context.move(to: CGPoint(x: width * 0.2, y: height * 0.5))
        context.addLine(to: CGPoint(x: width * 0.8, y: height * 0.5))
        context.move(to: CGPoint(x: width * 0.5, y: height * 0.2))
        context.addLine(to: CGPoint(x: width * 0.5, y: height * 0.8))
        context.drawPath(using: .stroke)
    }

    private func didTapButtonAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            self.transform = CGAffineTransform.identity
        }
    }
}
