//
//  DetailViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

final class DetailViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
    }
}
