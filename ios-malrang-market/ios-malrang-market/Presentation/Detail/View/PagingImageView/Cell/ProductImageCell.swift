//
//  ProductImageCell.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/02.
//

import UIKit

final class ProductImageCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContentView()
        self.setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentView() {
        self.contentView.backgroundColor = .systemBackground
        self.contentView.addSubview(self.imageView)
    }

    private func setupConstraint() {
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(image: UIImage) {
        self.imageView.image = image
    }
}
