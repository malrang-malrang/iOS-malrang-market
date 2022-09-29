//
//  DetailInfomationView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/01.
//

import RxSwift
import SnapKit

private enum Const {
    static let emptyString = ""
    static let priceInfomation = "%d원"
    static let stockLabelText = "재고수량 %d개"
    static let stockInfomation = "%d개"
}

final class DetailInfomationView: UIView {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.isUserInteractionEnabled = false
        return textView
    }()

    private let priceAndStockStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    private let stockLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let viewModel: DetailViewModelable
    private let disposeBag = DisposeBag()

    init(viewModel: DetailViewModelable) {
        self.viewModel = viewModel
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .systemBackground
        self.addSubviews(
            self.nameLabel,
            self.createdAtLabel,
            self.descriptionTextView,
            self.priceAndStockStackView
        )

        self.priceAndStockStackView.addArrangedSubviews(
            self.priceLabel,
            self.stockLabel
        )
    }

    private func setupConstraint() {
        self.nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        self.createdAtLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }

        self.descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(self.createdAtLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }

        self.priceAndStockStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func bind() {
        self.viewModel.productInfomation?
            .withUnretained(self)
            .subscribe(onNext: { infomationView, productInfomation in
                infomationView.nameLabel.text = productInfomation.name
                infomationView.createdAtLabel.text = infomationView.createdAtInfomation(at: productInfomation)
                infomationView.descriptionTextView.text = productInfomation.description
                infomationView.priceLabel.text = infomationView.priceInfomation(at: productInfomation)
                infomationView.stockLabel.attributedText = infomationView.stockInfomation(at: productInfomation)
            })
            .disposed(by: self.disposeBag)
    }

    private func createdAtInfomation(at product: ProductInfomation) -> String? {
        return product.createdAt.date()?.formatterString()
    }

    private func priceInfomation(at product: ProductInfomation) -> String? {
        guard let price = product.price.formatterString() else {
            return Const.emptyString
        }
        return String(format: Const.priceInfomation, price)
    }

    private func stockInfomation(at product: ProductInfomation) -> NSMutableAttributedString {
        guard let stock = product.stock.formatterString() else {
            return NSMutableAttributedString()
        }

        let stockLabel = String(format: Const.stockLabelText, stock)

        return NSMutableAttributedString(
            text: stockLabel,
            fontWeight: .bold,
            letter: String(format: Const.stockInfomation, stock)
        )
    }
}
