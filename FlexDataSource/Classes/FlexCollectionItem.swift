//
//  FlexCollectionItem.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 7/27/20.
//

import UIKit

public protocol FlexCollectionItem {
    func cellIdentifier() -> String
    func cellClass() -> UICollectionViewCell.Type
    func configureCell(_ cell: UICollectionViewCell)
}

open class ConcreteFlexCollectionItem<T>: FlexCollectionItem where T: UICollectionViewCell {
    var identifier: String = "cell"
    
    public init(identifier: String) {
        self.identifier = identifier
    }
    
    open func cellIdentifier() -> String {
        return identifier
    }
    
    open func cellClass() -> UICollectionViewCell.Type {
        return T.self
    }
    
    open func configureCell(_ cell: UICollectionViewCell) {
        // NO OP: override me!
    }
}

open class FunctionalFlexCollectionItem<T>: ConcreteFlexCollectionItem<T> where T: UICollectionViewCell {
    private let configureCell: (UICollectionViewCell) -> Void

    public init(identifier: String, _ configureCell: @escaping (UICollectionViewCell) -> Void) {
        self.configureCell = configureCell
        super.init(identifier: identifier)
    }

    open override func configureCell(_ cell: UICollectionViewCell) {
        configureCell(cell)
    }
}

open class TappableFlexCollectionItem<T>: FunctionalFlexCollectionItem<T>, Tappable where T: UICollectionViewCell {
    public var onTap: () -> Void
    
    public init(identifier: String, _ configureCell: @escaping (UICollectionViewCell) -> Void, _ onTap: @escaping () -> Void) {
        self.onTap = onTap
        super.init(identifier: identifier, configureCell)
    }
}
