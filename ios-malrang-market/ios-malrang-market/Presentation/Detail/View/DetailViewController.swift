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
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        return textView
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
        self.bind()
        self.configureTextView()
    }

    private func setupNavigationItem() {
        self.navigationItem.leftBarButtonItem = self.backBarButton
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(self.scrollView, self.textView)
        self.scrollView.addSubview(self.imageStackView)
    }

    private func setupConstraint() {
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
        }

        self.imageStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }

        self.textView.snp.makeConstraints {
            $0.top.equalTo(self.scrollView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
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
        let width = self.view.bounds.width * 0.3
        let size = CGSize(width: width, height: width)
        imageView.frame.size = size
        return imageView
    }

    private func configureTextView() {
        self.textView.text = self.product.name
    }
}
