//
//  FlexCollectionViewModel.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 6/14/22.
//

import fuikit
import Combine

open class FlexCollectionViewModel {
    open var dataSource: FlexCollectionDataSource { didSet { didSetDataSource() }}
    open var delegate: FPUICollectionViewDelegate { didSet { didSetTableDelegate() }}
    
    public var collectionView: UICollectionView? { didSet { configureTableView() }}
    
    public init(_ ds: FlexCollectionDataSource = FlexCollectionDataSource(), _ delegate: FPUICollectionViewDelegate = FPUICollectionViewDelegate()) {
        self.dataSource = ds
        self.delegate = delegate
    }
    
    open func didSetDataSource() { configureTableView() }
    open func didSetTableDelegate() { configureTableView() }
    open func configureTableView() {
        dataSource.collectionView = collectionView
        collectionView?.delegate = delegate
    }
}

public extension FlexCollectionViewModel {
    @available(iOS 13.0, *)
    convenience init(_ publisher: AnyPublisher<[FlexCollectionItem], Never>, _ cancelBag: inout Set<AnyCancellable>) {
        self.init()
        publisher.sink(receiveValue: dataSource.setItems(_:)).store(in: &cancelBag)
    }
}
