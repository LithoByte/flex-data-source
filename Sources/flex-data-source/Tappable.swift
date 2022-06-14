//
//  Tappable.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 8/25/20.
//

import Foundation

public protocol Tappable {
    var onTap: (() -> Void)? { get }
}

public func tap(on tappable: Tappable) {
    tappable.onTap?()
}
