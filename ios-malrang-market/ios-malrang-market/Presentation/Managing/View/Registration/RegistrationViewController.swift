//
//  RegistrationViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/11.
//

import RxSwift
import RxCocoa

private enum Const {
    static let registrationProduct = "상품 등록"
}

private enum Image {
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let back = UIImage(
        systemName: "arrowshape.turn.up.backward.fill",
        withConfiguration: Atribute.configuration
    )

    static let check = UIImage(
        systemName: "checkmark.diamond.fill",
        withConfiguration: Atribute.configuration
    )
}

final class RegistrationViewController: UIViewController, NotificationObservable {
    private let backBarButton: UIBarButtonItem = {
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

    private let checkBarButton: UIBarButtonItem = {
        let checkImage = Image.check
        let barButtonItem = UIBarButtonItem(
            image: checkImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let viewModel: ManagementViewModelable
    private let coordinator: ManagementViewCoordinatorProtocol
    private let managementView: ManagementView
    private let disposeBag = DisposeBag()

    init(viewModel: ManagementViewModelable, coordinator: ManagementViewCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.managementView = ManagementView(
            coordinator: coordinator,
            viewModel: viewModel
        )
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
        self.navigationItem.rightBarButtonItem = self.checkBarButton
        self.navigationItem.title = Const.registrationProduct
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.managementView.view)
    }

    private func setupConstraint() {
        self.managementView.view.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func bind() {
        self.backBarButton.rx.tap
            .withUnretained(self)
            .subscribe { registrationView, _ in
                registrationView.coordinator.popMenegementView()
            }
            .disposed(by: self.disposeBag)

        self.checkBarButton.rx.tap
            .withUnretained(self)
            .subscribe { registrationView, _ in
                let product = registrationView.managementView.extractData()
                registrationView.viewModel.productPost(product) {
                    registrationView.coordinator.popMenegementView()
                }
            }
            .disposed(by: self.disposeBag)
    }
}
