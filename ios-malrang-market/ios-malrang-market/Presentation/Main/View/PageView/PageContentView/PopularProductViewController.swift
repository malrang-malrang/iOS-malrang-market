//
//  PopularProductViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import UIKit

final class PopularProductViewController: UIViewController {
    private let viewModel: MainViewModelable

    init(viewModel: MainViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
