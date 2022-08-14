//
//  UIControl+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/13.
//

import Combine
import UIKit

extension UIControl {
    func controlPublisher(event: UIControl.Event) -> UIControl.EventPublisher {
        return EventPublisher(control: self, event: event)
    }
}

extension UIControl {
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never

        fileprivate var control: UIControl
        fileprivate var event: Event

        func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            let subscription = EventSubscription(subscriber: subscriber, event: self.event, control: self.control)
            subscriber.receive(subscription: subscription)
        }
    }
}

private extension UIControl {
    class EventSubscription<EventSubscriber: Subscriber>: Subscription
    where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {

        var subscriber: EventSubscriber?
        let event: UIControl.Event
        let control: UIControl

        init(subscriber: EventSubscriber, event: UIControl.Event, control: UIControl) {
            self.subscriber = subscriber
            self.event = event
            self.control = control
            self.control.addTarget(self, action: #selector(trigger), for: self.event)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            self.subscriber = nil
            self.control.removeTarget(self, action: #selector(trigger), for: self.event)
        }

        @objc func trigger() {
            _ = self.subscriber?.receive(control)
        }
    }
}
