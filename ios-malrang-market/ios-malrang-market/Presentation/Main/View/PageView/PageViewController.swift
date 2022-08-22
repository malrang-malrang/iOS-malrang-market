//
//  PageViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import RxCocoa
import RxSwift
import SnapKit

final class PageViewController: UIPageViewController {
    private let recentProductsView: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        return viewController
    }()

    private let popularProductsView: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        return viewController
    }()

    private lazy var pageList: [UIViewController] = {
        return [recentProductsView, popularProductsView]
    }()

    private let segmentView: SegmentView
    private var currentPage: Page
//    private let pageList: [PageView]
    private let viewModel: MainViewModelable
    private var disposeBag = DisposeBag()

    init(viewModel: MainViewModelable) {
        self.segmentView = SegmentView(viewModel: viewModel)
        self.currentPage = .recentProduct
//        self.pageList =
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageView()
        self.setupConstraints()
        self.bind()
    }

    private func setupPageView() {
        self.delegate = self
        self.dataSource = self
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.segmentView)
    }

    private func setupConstraints() {
        self.segmentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.06)
        }
    }

    private func bind() {
        self.viewModel.pageState
            .bind(onNext: { [weak self] page in
                self?.currentPage = page
                self?.switchView(state: page)
            })
            .disposed(by: self.disposeBag)
    }

    private func switchView(state: Page) {
        let vireController = self.pageList[state.value]
        let direction: UIPageViewController.NavigationDirection = {
            currentPage == .recentProduct ? .reverse : .forward
        }()
        self.setViewControllers([vireController], direction: direction, animated: true)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = self.pageList.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return pageList[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pageList.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = index + 1
        if nextIndex == pageList.count {
            return nil
        }
        return pageList[nextIndex]
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed {
            guard let viewController = pageViewController.viewControllers?[0],
                  let index = self.pageList.firstIndex(of: viewController) else {
                return
            }
            self.currentPage = Page(rawValue: index) ?? .recentProduct
            self.viewModel.didTapSegmentControl(selected: index)
        }
    }
}
