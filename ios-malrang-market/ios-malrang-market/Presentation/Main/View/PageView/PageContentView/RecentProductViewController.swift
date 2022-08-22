//
//  latelyProductViewController.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/15.
//

import RxCocoa
import RxSwift
import SnapKit

final class RecentProductViewController: UIViewController, PageView {
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    private func setupView() {
        self.view.addSubviews(self.tableView)
    }

    private func setupConstraint() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bind() {
        
    }
}
