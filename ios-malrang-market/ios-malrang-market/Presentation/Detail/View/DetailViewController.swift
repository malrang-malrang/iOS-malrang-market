//
//  DetailViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxCocoa
import RxSwift

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
        self.bind()
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
    }

    private func setupNavigationItem() {
        self.navigationItem.leftBarButtonItem = self.backBarButton
    }

    private func bind() {
        self.backBarButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.didTapBackBarButton()
            })
            .disposed(by: self.disposeBag)
    }
}
