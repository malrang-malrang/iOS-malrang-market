//
//  PageContentsViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

import Combine
import UIKit

import RxCocoa
import RxSwift

enum Page: Int, CaseIterable {
    case latelyProduct = 0
    case popularProduct = 1
}

extension Page {
    static var inventory: [String] {
        return Self.allCases.map { $0.description }
    }

    var value: Int {
        return self.rawValue
    }

    private var description: String {
        switch self {
        case .latelyProduct:
            return "최근 상품"
        case .popularProduct:
            return "인기 상품"
        }
    }
}

final class PageContentViewController: UIPageViewController {
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

    private var currentPage: Page
    private let viewModel: MainViewModelable
    private var disposeBag = DisposeBag()

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
            .bind(onNext: { [weak self] page in
                self?.currentPage = page
                self?.switchView(state: page)
            })
            .disposed(by: self.disposeBag)
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
            self.viewModel.didTapSegmentControl(selected: index)
        }
    }
}
