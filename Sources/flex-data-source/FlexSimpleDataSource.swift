//
//  FlexDataSource.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import fuikit

open class FlexDataSource: FPUITableViewDataSource, FlexDataSourceProtocol {
    
    public var tableView: UITableView? {
        didSet {
            registerCells()
            tableView?.dataSource = self
        }
    }
    public var sections: [FlexDataSourceSection]? {
        didSet {
            registerCells()
        }
    }
    
    required public init(_ tableView: UITableView? = nil, _ sections: [FlexDataSourceSection]? = nil) {
        super.init()
        self.tableView = tableView
        self.sections = sections
        
        onNumberOfSections = { [unowned self] _ in self.sections?.count ?? 0 }
        onNumberOfRowsInSection = { [unowned self] _, section in self.sections?[section].items?.count ?? 0 }
        onCellForRowAt = cell(from:forRowAt:)
        onTitleForHeaderInSection = titleForHeader(on:inSection:)
        onCanEditRowAt = canEditRow(in:at:)
        onCommitEditingStyleForRowAt = commitEditingStyleForRow(_:editingStyle:at:)
    }
    
    convenience init(_ items: [FlexDataSourceItem]) {
        let section = FlexDataSourceSection(title: nil, items: items)
        self.init(nil, [section])
    }
    
    convenience init(_ tableView: UITableView? = nil, _ items: [FlexDataSourceItem]) {
        let section = FlexDataSourceSection(title: nil, items: items)
        self.init(tableView, [section])
    }
}
