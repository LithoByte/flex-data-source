//
//  FlexDataSource.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit
import fuikit

open class FlexDataSource: FUITableViewDataSource {
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
    
    public init(_ tableView: UITableView? = nil, _ sections: [FlexDataSourceSection]? = nil) {
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
    
    open func registerCells() {
        if let sections = self.sections, let tableView = self.tableView {
            for section in sections {
                if let items = section.items {
                    for item in items {
                        let className = String(describing: item.cellClass())
                        let bundle = Bundle(for: item.cellClass())
                        if bundle.path(forResource: className, ofType: "nib") != nil {
                            tableView.register(UINib(nibName: className, bundle: bundle), forCellReuseIdentifier: item.cellIdentifier())
                        } else {
                            tableView.register(item.cellClass(), forCellReuseIdentifier: item.cellIdentifier())
                        }
                        
                    }
                }
            }
        }
    }
    
    // MARK: TableViewDataSource
    
    open func titleForHeader(on tableView: UITableView, inSection section: Int) -> String? {
        let isSectionView = tableView.delegate?.tableView?(tableView, viewForHeaderInSection: section) != nil
        return isSectionView ? nil : sections?[section].title
    }
    
    open func cell(from tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = sections?[indexPath.section].items?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier()) {
                item.configureCell(cell)
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - Tapping

public extension FlexDataSource {
    func tappableOnSelect(_ tableView: UITableView, _ indexPath: IndexPath) -> Void {
        tableView.deselectRow(at: indexPath, animated: true)
        if let tappable = sections?[indexPath.section].items?[indexPath.row] as? Tappable {
            tappable.onTap()
        }
    }
    
    func itemTapOnSelect(onTap: @escaping (FlexDataSourceItem) -> Void) -> (UITableView, IndexPath) -> Void {
        return { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
            if let item = self.sections?[indexPath.section].items?[indexPath.row] {
                onTap(item)
            }
        }
    }
}

// MARK: - Swiping
public extension FlexDataSource {
    func canEditRow(in tableView: UITableView, at indexPath: IndexPath) -> Bool {
        if let _ = sections?[indexPath.section].items?[indexPath.row] as? Swipable {
            return true
        }
        return false
    }
    
    func commitEditingStyleForRow(_ tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, at indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = sections?[indexPath.section].items?[indexPath.row] as? Swipable {
                item.onSwipe()
                sections?[indexPath.section].items?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
