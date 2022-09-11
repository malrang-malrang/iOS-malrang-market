//
//  ManagementView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/11.
//

import RxSwift
import SnapKit

final class ManagementView: UIView {
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()

    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private let addButton: AddButton = {
        let button = AddButton()
        button.layer.cornerRadius = 10
        return button
    }()

    private let imagepicker: UIImagePickerController = {
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .photoLibrary
        return imagepicker
    }()

    private let infomationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "상품명"
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "상품가격"
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let stockTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "재고수량"
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let descriptionTextView = UITextView()
    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubviews(self.imageScrollView, self.infomationStackView)

        self.imageScrollView.addSubview(self.imageStackView)
        self.imageStackView.addSubview(self.addButton)
        self.infomationStackView.addArrangedSubviews(
            self.nameTextField,
            self.priceTextField,
            self.stockTextField,
            self.descriptionTextView
        )
    }

    private func setupConstraint() {
        self.imageScrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }

        self.imageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.addButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(self.addButton.snp.width)
        }

        self.infomationStackView.snp.makeConstraints {
            $0.top.equalTo(self.imageScrollView.snp.bottom).inset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
