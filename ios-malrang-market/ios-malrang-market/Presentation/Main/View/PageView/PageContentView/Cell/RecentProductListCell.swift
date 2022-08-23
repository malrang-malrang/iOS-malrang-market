//
//  RecentProductListCell.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import UIKit

final class RecentProductListCell: UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }

    private let productImageView: UIImageView = {
        let image = UIImage(named: "malrang")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "상품 이름"
        return label
    }()

    private let productIssuedAtLabel: UILabel = {
        let label = UILabel()
        label.text = "끌올 1분전"
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "상품 가격"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
        self.setupContentView()
        self.setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        self.contentView.backgroundColor = .systemBackground
    }

    private func setupContentView() {
        self.contentView.addSubviews(self.productImageView, self.descriptionStackView)
        self.descriptionStackView.addArrangedSubviews(
            self.productNameLabel,
            self.productIssuedAtLabel,
            self.productPriceLabel
        )
    }

    private func setupConstraint() {
        self.productImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(self.productImageView.snp.width)
        }

        self.descriptionStackView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(self.productImageView.snp.trailing).offset(10)
        }
    }

    func configure(product: ProductDetail?) {
        guard let product = product else {
            return
        }
        print(product)
    }
}
