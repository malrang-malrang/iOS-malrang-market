//
//  ManagementView.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/11.
//

import RxSwift
import SnapKit

final class ManagementView: UIViewController {
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()

    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
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
        stackView.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "상품명"
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.setContentHuggingPriority(.required, for: .vertical)
        return textField
    }()

    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "상품가격"
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.setContentHuggingPriority(.required, for: .vertical)
        return textField
    }()

    private let stockTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "재고수량"
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.setContentHuggingPriority(.required, for: .vertical)
        return textField
    }()

    private let descriptionTextView = UITextView()
    private let coordinator: MenegementCoordinatorProtocol
    private let disposeBag = DisposeBag()

    init(coordinator: MenegementCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    private func setupView() {
        self.imagepicker.delegate = self
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(self.imageScrollView, self.infomationStackView)

        self.imageScrollView.addSubview(self.imageStackView)
        self.imageStackView.addArrangedSubview(self.addButton)
        self.infomationStackView.addArrangedSubviews(
            self.nameTextField,
            self.priceTextField,
            self.stockTextField,
            self.descriptionTextView
        )
    }

    private func setupConstraint() {
        self.imageScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }

        self.imageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(self.imageScrollView.snp.height)
        }

        self.addButton.snp.makeConstraints {
            $0.width.equalTo(self.imageScrollView.snp.height).multipliedBy(0.8)
            $0.height.equalTo(self.addButton.snp.width)
        }

        self.infomationStackView.snp.makeConstraints {
            $0.top.equalTo(self.imageScrollView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }

    private func bind() {
        self.addButton.rx.tap
            .subscribe { _ in
                self.coordinator.showPhotoLibrary(self.imagepicker)
            }
            .disposed(by: self.disposeBag)

        guard let image = UIImage(systemName: "swift") else {
            return
        }
        self.addImage(image)
    }

    private func addImage(_ image: UIImage) {
        let imageView: UIImageView = {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

        self.imageStackView.insertArrangedSubview(
            imageView,
            at: self.imageStackView.arrangedSubviews.count
        )
    }
}

extension ManagementView: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }

        self.addImage(image)
        self.coordinator.dismissPhotoLibrary(picker)
    }
}
