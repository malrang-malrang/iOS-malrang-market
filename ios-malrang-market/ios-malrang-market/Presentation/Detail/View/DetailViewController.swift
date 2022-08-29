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
//        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()

    private let addImageButton: AddButton = {
        let button = AddButton()
        button.layer.cornerRadius = 10
        return button
    }()

    private let imageView: UIImageView = {
        let image = UIImage(named: "malrang")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private let textView = UITextView()

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
        self.setupView()
        self.setupNavigationItem()
        self.setupConstraint()
        self.bind()
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(self.scrollView, self.textView)
        self.scrollView.addSubview(self.imageStackView)
        self.imageStackView.addArrangedSubviews(self.addImageButton, self.imageView)
    }

    private func setupNavigationItem() {
        self.navigationItem.leftBarButtonItem = self.backBarButton
    }

    private func setupConstraint() {
        self.scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }

        self.imageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        self.addImageButton.snp.makeConstraints {
            $0.width.equalTo(self.imageStackView.snp.width).multipliedBy(0.45)
            $0.height.equalTo(self.addImageButton.snp.width)
        }

        self.imageView.snp.makeConstraints {
            $0.width.equalTo(self.imageStackView.snp.width).multipliedBy(0.45)
            $0.height.equalTo(self.imageView.snp.width)
        }

        self.textView.snp.makeConstraints {
            $0.top.equalTo(self.scrollView.snp.bottom).inset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }

    private func bind() {
        self.backBarButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.didTapBackBarButton()
            })
            .disposed(by: self.disposeBag)
    }
}
