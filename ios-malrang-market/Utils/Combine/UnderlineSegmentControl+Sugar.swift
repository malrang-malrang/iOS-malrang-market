//
//  SegmentControl+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/13.
//

import Combine
import UIKit

extension UnderlineSegmentControl {
    var selectedPublisher: AnyPublisher<Page, Never> {
        return controlPublisher(event: .valueChanged)
            .compactMap { $0 as? UnderlineSegmentControl }
            .compactMap { Page(rawValue: $0.selectedSegmentIndex) }
            .eraseToAnyPublisher()
    }
}
