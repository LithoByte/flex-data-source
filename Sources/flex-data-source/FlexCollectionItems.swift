//
//  FlexCollectionItems.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 10/11/21.
//

import Foundation
import LithoOperators
import Prelude

open class FlexModelCollectionItem<T, C>: ConcreteFlexCollectionItem<C>, Tappable where C: UICollectionViewCell {
    open var model: T
    open var configurer: (C) -> Void
    public var onTap: (() -> Void)?
    public var onButtonPressed: (() -> Void)?
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
                buttonPressed: @escaping () -> Void) {
        self.onButtonPressed = buttonPressed
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    public init(model: T,
                configurer: @escaping (T, C) -> Void,
                tap: @escaping (T) -> Void,
                buttonPressed: @escaping (T) -> Void) {
        self.onButtonPressed = voidCurry(model, buttonPressed)
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    override open func configureCell(_ cell: UICollectionViewCell) {
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

public func modelItem<T, U: UICollectionViewCell>(_ configurer: @escaping (T, U) -> Void) -> (T) -> FlexModelCollectionItem<T, U> {
    return configurer -*> FlexModelCollectionItem.init
}

public func tappableModelItem<T, U: UICollectionViewCell>(_ configurer: @escaping (T, U) -> Void, onTap: @escaping (T) -> Void) -> (T) -> FlexModelCollectionItem<T, U> {
    return (configurer, onTap) -**> FlexModelCollectionItem.init
}

