//
//  Swipeable.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 8/25/20.
//

import Foundation

public protocol Swipable {
    var onSwipe: (() -> Void)? { get }
}

public func swipe(on swipable: Swipable) {
    swipable.onSwipe?()
}
