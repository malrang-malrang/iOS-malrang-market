//
//  FavoriteButton.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/01.
//

import UIKit

private enum Image {
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let heart = UIImage(
        systemName: "heart",
        withConfiguration: Atribute.configuration
    )

    static let fillHeart = UIImage(
        systemName: "heart.fill",
        withConfiguration: Atribute.configuration
    )
}

final class FavoriteButton: UIButton {
    override var isSelected: Bool {
        didSet {
            self.changeImage()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        self.backgroundColor = .systemBackground
        self.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        self.setImage(Image.heart, for: .normal)
    }

    private func changeImage() {
        if self.isSelected {
            self.setImage(Image.fillHeart, for: .selected)
        } else {
            self.setImage(Image.heart, for: .normal)
        }
    }
}
