//
//  PageContentsViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import Combine
import UIKit

final class PageContentViewController: UIPageViewController {
    private let recentProductsView: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        return viewController
    }()

    private let popularProductsView: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .green
        return viewController
    }()

    private lazy var pageList: [UIViewController] = {
        return [recentProductsView, popularProductsView]
    }()

    private var currentPage: Page
    private let viewModel: MainViewModelable
    private var cancellableBag = Set<AnyCancellable>()

    init(viewModel: MainViewModelable) {
        self.currentPage = .latelyProduct
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
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    private func bind() {
        self.viewModel.pageState
            .sink { [weak self] type in
                self?.currentPage = type
                self?.switchView(state: type)
            }
            .store(in: &self.cancellableBag)
    }

    private func switchView(state: Page) {
        let vireController = self.pageList[state.value]
        let direction: UIPageViewController.NavigationDirection = {
            currentPage == .latelyProduct ? .reverse : .forward
        }()
        self.setViewControllers([vireController], direction: direction, animated: true)
    }
}

extension PageContentViewController: UIPageViewControllerDataSource {
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

extension PageContentViewController: UIPageViewControllerDelegate {
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
            self.currentPage = Page(rawValue: index) ?? .latelyProduct
            self.viewModel.didTapSegmentControl(selected: currentPage)
        }
    }
}
