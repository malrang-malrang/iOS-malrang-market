//
//  SearchedProductCell.swift
//  ios-malrang-market
//
//  Created by ê¹ëì± on 2022/09/15.
//

import RxSwift

private enum Const {
    static let emptyString = ""
    static let priceInfomation = "%dì"
}

final class SearchedProductCell: UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
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

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private(set) var constructedProduct : ProductInfomation?

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

        self.contentView.addSubviews(self.contentStackView)
        self.contentStackView.addArrangedSubviews(
            self.productImageView,
            self.descriptionStackView
        )
        self.descriptionStackView.addArrangedSubviews(
            self.nameLabel,
            self.createdAtLabel,
            self.priceLabel
        )
    }

    private func setupConstraint() {
        self.contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        self.productImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(self.productImageView.snp.width)
        }
    }

    func configure(product: ProductInfomation) {
        self.constructedProduct = product
        self.nameLabel.text = product.name
        self.createdAtLabel.text = self.createdAtInfomation(from: product)
        self.priceLabel.text = self.priceInfomation(from: product)
        self.productImageView.setImage(with: product.thumbnailImageURLString)
    }

    private func createdAtInfomation(from: ProductInfomation) -> String? {
        return from.createdAt.date()?.formatterString()
    }

    private func priceInfomation(from: ProductInfomation) -> String? {
        guard let price = from.price.formatterString() else {
            return Const.emptyString
        }
        return String(format: Const.priceInfomation, price)
    }
}
