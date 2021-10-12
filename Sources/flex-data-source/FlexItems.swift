//
//  FlexItems.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 10/11/21.
//

import Foundation
import LithoOperators
import Prelude

open class FlexModelItem<T, C>: ConcreteFlexDataSourceItem<C> where C: UITableViewCell {
    open var model: T
    open var configurer: (C) -> Void
    
    public init(_ model: T, _ configurer: @escaping (T, C) -> Void) {
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    override open func configureCell(_ cell: UITableViewCell) {
        if let cell = cell as? C {
            configurer(cell)
        }
    }
}

open class FlexTappableModelItem<T, C>: FlexModelItem<T, C>, Tappable where C: UITableViewCell {
    public var onTap: () -> Void = {}
    
    public init(model: T, configurer: @escaping (T, C) -> Void, tap: @escaping (T) -> Void) {
        self.onTap = voidCurry(model, tap)
        super.init(model, configurer)
    }
}

open class FlexSwipeTapModelItem<T, C>: FlexTappableModelItem<T, C>, Swipable where C: UITableViewCell {
    public var onSwipe: () -> Void
    
    public init(model: T,
                configurer: @escaping (T, C) -> Void,
                tap: @escaping (T) -> Void,
                swipe: @escaping () -> Void) {
        self.onSwipe = swipe
        super.init(model: model, configurer: configurer, tap: tap)
    }
    
    public init(model: T,
                configurer: @escaping (T, C) -> Void,
                tap: @escaping (T) -> Void,
                swipe: @escaping (T) -> Void) {
        self.onSwipe = voidCurry(model, swipe)
        super.init(model: model, configurer: configurer, tap: tap)
    }
}

public func modelItem<T, U: UITableViewCell>(_ configurer: @escaping (T, U) -> Void) -> (T) -> FlexModelItem<T, U> {
    return configurer -*> FlexModelItem.init
}

public func tappableModelItem<T, U: UITableViewCell>(_ configurer: @escaping (T, U) -> Void, onTap: @escaping (T) -> Void) -> (T) -> FlexTappableModelItem<T, U> {
    return (configurer, onTap) -**> FlexTappableModelItem.init
}

public func swipeTappableModelItem<T, U: UITableViewCell>(_ configurer: @escaping (T, U) -> Void, onTap: @escaping (T) -> Void, onSwipe: @escaping (T) -> Void) -> (T) -> FlexSwipeTapModelItem<T, U> {
    return (configurer, onTap, onSwipe) -***> FlexSwipeTapModelItem.init
}
