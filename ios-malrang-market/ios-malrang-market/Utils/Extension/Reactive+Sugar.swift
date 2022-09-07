//
//  Reactive+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/07.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UITableView {
    func modelLongPressed<T>(_ modelType: T.Type) -> ControlEvent<(UITableViewCell, T)> {
        let longPressGesture: UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer(target: nil, action: nil)
            gesture.minimumPressDuration = 0.5
            return gesture
        }()

        base.addGestureRecognizer(longPressGesture)
        let source = longPressGesture.rx.event
            .filter { $0.state == .began }
            .map { base.indexPathForRow(at: $0.location(in: base)) }
            .flatMap { [weak tableView = base as UITableView] indexPath -> Observable<(UITableViewCell, T)> in
                guard let tableView = tableView,
                      let indexPath = indexPath,
                      let cell = tableView.cellForRow(at: indexPath) else {
                    return Observable.empty()
                }
                return Observable.zip(
                    Observable.just(cell),
                    Observable.just(try tableView.rx.model(at: indexPath))
                )
            }
        return ControlEvent(events: source)
    }
}

extension Reactive where Base: UICollectionView {
    func modelLongPressed<T>(_ modelType: T.Type) -> ControlEvent<(UICollectionViewCell, T)> {
        let longPressGesture: UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer(target: nil, action: nil)
            gesture.minimumPressDuration = 0.5
            return gesture
        }()

        base.addGestureRecognizer(longPressGesture)
        let source = longPressGesture.rx.event
            .filter { $0.state == .began }
            .map { base.indexPathForItem(at: $0.location(in: base))}
            .flatMap { [weak collectionView = base as UICollectionView] indexPath -> Observable<(UICollectionViewCell, T)> in
                guard let collectionView = collectionView,
                      let indexPath = indexPath,
                      let cell = collectionView.cellForItem(at: indexPath) else {
                    return Observable.empty()
                }
                return Observable.zip(
                    Observable.just(cell),
                    Observable.just(try collectionView.rx.model(at: indexPath))
                )
            }
        return ControlEvent(events: source)
    }
}
