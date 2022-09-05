//
//  MainViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/03.
//

import RxCocoa
import RxSwift
import SnapKit

private enum Const {
    static let searchBarPlaceholder = "말랑마켓 통합검색"
}

private enum Image {
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let bookmark = UIImage(
        systemName: "bookmark",
        withConfiguration: Atribute.configuration
    )
}

final class MainViewController: UIViewController, AlertProtocol {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Const.searchBarPlaceholder
        return searchBar
    }()

    private let bookmarkBarButton: UIBarButtonItem = {
        let bookMarkImage = Image.bookmark
        let barButtonItem = UIBarButtonItem(
            image: bookMarkImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1)
        return barButtonItem
    }()

    private let addButton: AddButton = {
        let button = AddButton()
        button.layer.cornerRadius = 27
        return button
    }()

    private let segmentView: SegmentView
    private let pageView: PageViewController
    private let viewModel: MainViewModelable
    private let coordinator: MainViewCoordinatorProtocol
    private let disposeBag = DisposeBag()

    init(viewModel: MainViewModelable, coordinator: MainViewCoordinatorProtocol) {
        self.segmentView = SegmentView(viewModel: viewModel)
        self.pageView = PageViewController(viewModel: viewModel, coordinator: coordinator)
        self.viewModel = viewModel
        self.coordinator = coordinator
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
        self.navigationItem.titleView = self.searchBar
        self.navigationItem.rightBarButtonItem = self.bookmarkBarButton
    }

    private func setupView() {
        self.addChild(self.pageView)
        self.pageView.didMove(toParent: self)
        self.view.addSubviews(self.segmentView, self.pageView.view, self.addButton)
        self.view.backgroundColor = .systemBackground
    }

    private func setupConstraint() {
        self.segmentView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.05)
        }

        self.pageView.view.snp.makeConstraints {
            $0.top.equalTo(self.segmentView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        self.addButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalToSuperview().inset(40)
            $0.width.equalToSuperview().multipliedBy(0.13)
            $0.height.equalTo(self.addButton.snp.width)
        }
    }

    private func bind() {
        self.bookmarkBarButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { mainView, _ in
                mainView.coordinator.showRegistrationView()
            })
            .disposed(by: self.disposeBag)

        self.viewModel.error?
            .withUnretained(self)
            .subscribe(onNext: { mainView, error in
                let alert = mainView.makeAlert(title: error.localizedDescription)
                mainView.coordinator.showAlert(alert: alert)
            })
            .disposed(by: self.disposeBag)
    }
}
