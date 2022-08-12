//
//  PageContentsViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/12.
//

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

    private lazy var dataViewList: [UIViewController] = {
        return [recentProductsView, popularProductsView]
    }()

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageView()
    }

    private func setupPageView() {
        self.dataSource = self
        self.view.translatesAutoresizingMaskIntoConstraints = false
        if let firstViewController = self.dataViewList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
    }
}

extension PageContentViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewList.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewList[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewList.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewList.count {
            return nil
        }
        return dataViewList[nextIndex]
    }
}
