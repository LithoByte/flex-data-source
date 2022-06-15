//
//  FlexTableViewModel.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 6/12/22.
//

import fuikit
import Combine

open class FlexTableViewModel {
    open var dataSource: FlexDataSource { didSet { didSetDataSource() }}
    open var tableDelegate: FPUITableViewDelegate { didSet { didSetTableDelegate() }}
    
    public var tableView: UITableView? { didSet { configureTableView() }}
    
    public init(_ ds: FlexDataSource = FlexDataSource(), _ delegate: FPUITableViewDelegate = FPUITableViewDelegate()) {
        self.dataSource = ds
        self.tableDelegate = delegate
    }
    
    open func didSetDataSource() { configureTableView() }
    open func didSetTableDelegate() { configureTableView() }
    open func configureTableView() {
        dataSource.tableView = tableView
        tableView?.delegate = tableDelegate
    }
}

public extension FlexTableViewModel {
    @available(iOS 13.0, *)
    convenience init(_ publisher: AnyPublisher<[FlexDataSourceItem], Never>, _ cancelBag: inout Set<AnyCancellable>) {
        self.init()
        publisher.sink(receiveValue: dataSource.setItems(_:)).store(in: &cancelBag)
    }
}
