//
//  RandomProductListCell.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/06.
//

import UIKit

private enum Const {
    static let emptyString = ""
    static let priceInfomation = "%d원"
    static let stockLabelText = "재고수량 %d개"
    static let stockInfomation = "%d개"
}

final class RandomProductListCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private let infomationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        return stackView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private let discriptionlabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private let stockLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private(set) var constructedProduct : ProductInfomation?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContentView()
        self.setupConstraint()
        self.setupBorder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentView() {
        self.contentView.backgroundColor = .systemBackground

        self.contentView.addSubviews(self.contentStackView, self.infomationStackView)
        self.contentStackView.addArrangedSubviews(
            self.imageView,
            self.infomationStackView
        )

        self.infomationStackView.addArrangedSubviews(
            self.nameLabel,
            self.discriptionlabel,
            self.priceLabel,
            self.stockLabel
        )
    }

    private func setupConstraint() {
        self.contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        self.imageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(self.imageView.snp.width)
        }
    }

    private func setupBorder() {
        let border = self.layer.addBorder(
            edges: [.all],
            color: .systemGray3,
            thickness: 2,
            radius: 10
        )
        self.layer.addSublayer(border)
    }

    func configure(product: ProductInfomation) {
        self.constructedProduct = product
//        self.imageView.image = product.thumbnail?.image()
        self.nameLabel.text = product.name
        self.discriptionlabel.text = product.description
        self.priceLabel.text = self.priceInfomation(from: product)
        self.stockLabel.attributedText = self.stockInfomation(from: product)
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

    private func stockInfomation(from: ProductInfomation) -> NSMutableAttributedString {
        guard let stock = from.stock.formatterString() else {
            return NSMutableAttributedString()
        }

        let stockLabelText = String(format: Const.stockLabelText, stock)

        return NSMutableAttributedString(
            text: stockLabelText,
            fontWeight: .bold,
            letter: String(format: Const.stockInfomation, stock)
        )
    }
}
