//
//  FlexCollectionItems.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 10/11/21.
//

import Foundation
import LithoOperators
import Prelude

open class FlexModelCollectionItem<T, C>: ConcreteFlexCollectionItem<C> where C: UICollectionViewCell {
    open var model: T
    open var configurer: (C) -> Void
    
    public init(_ model: T, _ configurer: @escaping (T, C) -> Void) {
        self.model = model
        self.configurer = model *-> configurer
        super.init(identifier: String(describing: C.self))
    }
    
    override open func configureCell(_ cell: UICollectionViewCell) {
        if let cell = cell as? C {
            configurer(cell)
        }
    }
}

open class FlexTappableModelCollectionItem<T, C>: FlexModelCollectionItem<T, C>, Tappable where C: UICollectionViewCell {
    public var onTap: () -> Void = {}
    
    public init(model: T, configurer: @escaping (T, C) -> Void, tap: @escaping (T) -> Void) {
        self.onTap = voidCurry(model, tap)
        super.init(model, configurer)
    }
}

open class FlexButtonTappableModelCollectionItem<T, C>: FlexTappableModelCollectionItem<T, C> where C: UICollectionViewCell {
    public var onButtonPressed: () -> Void
    
    public init(model: T,
                configurer: @escaping (T, C) -> Void,
                tap: @escaping (T) -> Void,
                buttonPressed: @escaping () -> Void) {
        self.onButtonPressed = buttonPressed
        super.init(model: model, configurer: configurer, tap: tap)
    }
    
    public init(model: T,
                configurer: @escaping (T, C) -> Void,
                tap: @escaping (T) -> Void,
                buttonPressed: @escaping (T) -> Void) {
        self.onButtonPressed = voidCurry(model, buttonPressed)
        super.init(model: model, configurer: configurer, tap: tap)
    }
}

open class FlexGestureModelCollectionItem<T, C>: FlexModelCollectionItem<T, C> where C: UICollectionViewCell {
    public var gestureRecognizer: UIGestureRecognizer?
    public var onGesture: ((T, UIGestureRecognizer?) -> Void)?
    
    override open func configureCell(_ cell: UICollectionViewCell) {
        if let recognizer = gestureRecognizer {
            cell.contentView.removeGestureRecognizer(recognizer)
            cell.contentView.addGestureRecognizer(recognizer)
        }
        super.configureCell(cell)
    }
    
    @objc open func gesturePerformed() {
        onGesture?(model, gestureRecognizer)
    }
}

public func modelItem<T, U: UICollectionViewCell>(_ configurer: @escaping (T, U) -> Void) -> (T) -> FlexModelCollectionItem<T, U> {
    return configurer -*> FlexModelCollectionItem.init
}

public func tappableModelItem<T, U: UICollectionViewCell>(_ configurer: @escaping (T, U) -> Void, onTap: @escaping (T) -> Void) -> (T) -> FlexTappableModelCollectionItem<T, U> {
    return (configurer, onTap) -**> FlexTappableModelCollectionItem.init
}

