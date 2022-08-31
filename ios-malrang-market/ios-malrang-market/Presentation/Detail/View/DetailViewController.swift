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
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let back = UIImage(
        systemName: "arrowshape.turn.up.backward.fill",
        withConfiguration: Atribute.configuration
    )
}

final class DetailViewController: UIViewController {
    private let backBarButton: UIBarButtonItem = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
        let bookMarkImage = Image.back
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
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private let favoriteButton = FavoriteButton()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
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
            $0.height.equalToSuperview().multipliedBy(0.45)
        }

        self.imageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
            $0.height.equalToSuperview().inset(20)
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

    private func bind() {
        let productInfomation = self.viewModel.productInfomation()

        self.nameLabel.text = productInfomation.name
        self.createdAtLabel.text = productInfomation.createdAt
        self.descriptionTextView.text = productInfomation.description
        self.priceLabel.text = productInfomation.price
        self.stockLabel.attributedText = productInfomation.stock

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

        self.favoriteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.favoriteButton.isSelected.toggle()
            })
            .disposed(by: self.disposeBag)
    }

    private func addProductImage(images: [UIImage]?) {
        images?.forEach { image in
            let imageView = self.generateImageView(image: image)
            self.imageStackView.addArrangedSubview(imageView)
        }
    }

    private func generateImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        imageView.snp.makeConstraints { $0.width.equalTo(imageView.snp.height) }

        return imageView
    }
}
