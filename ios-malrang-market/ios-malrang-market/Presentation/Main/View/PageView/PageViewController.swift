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
    private var currentPage: Page
    private let pageList: [UIViewController]
    private let viewModel: MainViewModelable
    private var disposeBag = DisposeBag()

    init(viewModel: MainViewModelable, coordinator: MainViewCoordinatorProtocol) {
        self.currentPage = .recentProduct
        self.pageList = [
            RecentProductViewController(viewModel: viewModel, coordinator: coordinator),
            RandomProductViewController(viewModel: viewModel, coordinator: coordinator)
        ]
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageView()
        self.bind()
    }

    private func setupPageView() {
        self.delegate = self
        self.dataSource = self
    }

    private func bind() {
        self.viewModel.pageState
            .withUnretained(self)
            .bind(onNext: { pageView, page in
                pageView.currentPage = page
                pageView.switchView(state: page)
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
