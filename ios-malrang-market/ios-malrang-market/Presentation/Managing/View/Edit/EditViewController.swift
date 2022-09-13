//
//  EditViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/14.
//

import RxCocoa
import RxSwift

private enum Const {
    static let editProduct = "상품 수정"
}

private enum Image {
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let back = UIImage(
        systemName: "arrowshape.turn.up.backward.fill",
        withConfiguration: Atribute.configuration
    )

    static let edit = UIImage(
        systemName: "square.and.pencil",
        withConfiguration: Atribute.configuration
    )

    static let trash = UIImage(
        systemName: "trash",
        withConfiguration: Atribute.configuration
    )}

final class EditViewController: UIViewController {
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

    private let editBarButton: UIBarButtonItem = {
        let editImage = Image.edit
        let barButtonItem = UIBarButtonItem(
            image: editImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let deleteBarButton: UIBarButtonItem = {
        let trashImage = Image.trash
        let barButtonItem = UIBarButtonItem(
            image: trashImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let viewModel: ManagementViewModelable
    private let coordinator: MenegementCoordinatorProtocol
    private let managementView: ManagementView
    private let disposeBag = DisposeBag()

    init(viewModel: ManagementViewModelable, coordinator: MenegementCoordinatorProtocol) {
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
        self.navigationItem.rightBarButtonItems = [self.editBarButton, self.deleteBarButton]
        self.navigationItem.title = Const.editProduct
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
            .subscribe { editView, _ in
                editView.coordinator.popMenegementView()
            }
            .disposed(by: self.disposeBag)
    }
}
