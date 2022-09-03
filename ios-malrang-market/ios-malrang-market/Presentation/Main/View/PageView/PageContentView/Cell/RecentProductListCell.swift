//
//  RecentProductListCell.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift

private enum Const {
    static let emptyString = ""
}

final class RecentProductListCell: UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }

    private let productContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()

    private let productImageView: UIImageView = {
        let image = UIImage(named: "malrang")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let productCreatedAtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupContentView()
        self.setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentView() {
        self.contentView.backgroundColor = .systemBackground

        self.contentView.addSubviews(self.productContentStackView)
        self.productContentStackView.addArrangedSubviews(
            self.productImageView,
            self.descriptionStackView
        )
        self.descriptionStackView.addArrangedSubviews(
            self.productNameLabel,
            self.productCreatedAtLabel,
            self.productPriceLabel
        )
    }

    private func setupConstraint() {
        self.productContentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        self.productImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(self.productImageView.snp.width)
        }
    }

    func configure(product: ProductDetail) {
        self.productNameLabel.text = product.name
        self.productCreatedAtLabel.text = self.createdAtInfomation(from: product)
        self.productPriceLabel.text = self.priceInfomation(from: product)
    }

    private func createdAtInfomation(from: ProductDetail) -> String? {
        return from.createdAt?.date()?.formatterString()
    }

    private func priceInfomation(from: ProductDetail) -> String? {
        guard let price = from.price?.formatterString() else {
            return ""
        }
        return "\(price)원"
    }
}
