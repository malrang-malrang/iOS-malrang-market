//
//  DetailViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxCocoa
import RxSwift
import SnapKit

private enum Image {
    static let back = "arrowshape.turn.up.backward.fill"
}

final class DetailViewController: UIViewController {
    private let backBarButton: UIBarButtonItem = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
        let bookMarkImage = UIImage(systemName: Image.back, withConfiguration: configuration)
        let barButtonItem = UIBarButtonItem(
            image: bookMarkImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let scrollView: UIScrollView = {
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

    private let infomationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

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
        stackView.distribution = .equalCentering
        return stackView
    }()

    private let favoriteButton: UIButton = {
        let unselectedImage = UIImage(systemName: "heart")
        let selectedImage = UIImage(systemName: "heart.fill")
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        button.setImage(unselectedImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        return button
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private let stockLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let product: ProductDetail
    private let viewModel: DetailViewModelable
    private let disposeBag = DisposeBag()

    init(product: ProductDetail, viewModel: DetailViewModelable) {
        self.product = product
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem()
        self.setupView()
        self.setupConstraint()
        self.configure()
        self.bind()
    }

    private func setupNavigationItem() {
        self.navigationItem.leftBarButtonItem = self.backBarButton
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(
            self.scrollView,
            self.infomationStackView,
            self.priceAndStockStackView
        )
        self.scrollView.addSubview(self.imageStackView)
        self.infomationStackView.addArrangedSubviews(
            self.nameLabel,
            self.createdAtLabel,
            self.descriptionTextView
        )
        self.priceAndStockStackView.addArrangedSubviews(
            self.favoriteButton,
            self.priceLabel,
            self.stockLabel
        )
    }

    private func setupConstraint() {
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.35)
        }

        self.imageStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }

        self.infomationStackView.snp.makeConstraints {
            $0.top.equalTo(self.scrollView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        self.descriptionTextView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
        }

        self.priceAndStockStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
    }

    private func configure() {
        self.nameLabel.text = self.product.name
        self.createdAtLabel.text = self.product.createdAt
        self.descriptionTextView.text = self.product.name
        self.priceLabel.text = self.product.price?.description
        self.stockLabel.text = self.product.stock?.description
    }

    private func bind() {
        self.backBarButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.didTapBackBarButton()
            })
            .disposed(by: self.disposeBag)

        self.viewModel.productImages
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] images in
                self?.addProductImage(images: images)
            })
            .disposed(by: self.disposeBag)
    }

    private func addProductImage(images: [UIImage]?) {
        guard let images = images else { return }

        images.forEach { [weak self] image in
            guard let imageView = self?.generateImageView(image: image) else { return }
            self?.imageStackView.addArrangedSubview(imageView)
        }
    }

    private func generateImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        let width = self.view.bounds.width * 0.9

        imageView.snp.makeConstraints { $0.width.height.equalTo(width) }

        return imageView
    }
}
