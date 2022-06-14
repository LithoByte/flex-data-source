//
//  FlexItems.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 10/11/21.
//

import Foundation
import LithoOperators
import Prelude

open class FlexModelItem<T, C>: ConcreteFlexDataSourceItem<C>, Tappable, Swipable where C: UITableViewCell {
    open var model: T
    open var configurer: (C) -> Void
    public var onTap: (() -> Void)?
    public var onSwipe: (() -> Void)?
    public var gestureRecognizer: UIGestureRecognizer?
    public var onGesture: ((T, UIGestureRecognizer?) -> Void)?
    
    public init(_ model: T, _ configurer: @escaping (T, C) -> Void) {
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    public init(model: T, configurer: @escaping (T, C) -> Void, tap: @escaping (T) -> Void) {
        self.onTap = voidCurry(model, tap)
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    public init(model: T,
                configurer: @escaping (T, C) -> Void,
                tap: @escaping (T) -> Void,
                swipe: @escaping () -> Void) {
        self.onSwipe = swipe
        self.onTap = voidCurry(model, tap)
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    public init(model: T,
                configurer: @escaping (T, C) -> Void,
                tap: @escaping (T) -> Void,
                swipe: @escaping (T) -> Void) {
        self.onSwipe = voidCurry(model, swipe)
        self.onTap = voidCurry(model, tap)
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    override open func configureCell(_ cell: UITableViewCell) {
        if let recognizer = gestureRecognizer {
            cell.contentView.removeGestureRecognizer(recognizer)
            cell.contentView.addGestureRecognizer(recognizer)
        }
        if let cell = cell as? C {
            configurer(cell)
        }
    }
    
    @objc open func gesturePerformed() {
        onGesture?(model, gestureRecognizer)
    }
}

public func modelItem<T, U: UITableViewCell>(_ configurer: @escaping (T, U) -> Void) -> (T) -> FlexModelItem<T, U> {
    return configurer -*> FlexModelItem.init
}

public func tappableModelItem<T, U: UITableViewCell>(_ configurer: @escaping (T, U) -> Void, onTap: @escaping (T) -> Void) -> (T) -> FlexModelItem<T, U> {
    return (configurer, onTap) -**> FlexModelItem.init
}

public func swipeTappableModelItem<T, U: UITableViewCell>(_ configurer: @escaping (T, U) -> Void, onTap: @escaping (T) -> Void, onSwipe: @escaping (T) -> Void) -> (T) -> FlexModelItem<T, U> {
    return (configurer, onTap, onSwipe) -***> FlexModelItem.init
}
