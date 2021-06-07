//
//  FlexDataSourceProtocol.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 4/19/21.
//

import Foundation
import fuikit

public protocol FlexDataSourceProtocol {
    var tableView: UITableView? { get set }
    var sections: [FlexDataSourceSection]? { get set }
}

extension FlexDataSourceProtocol {
    
    public func registerCells() {
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
    
    //MARK: - UITableViewDataSource
    
    public func titleForHeader(on tableView: UITableView, inSection section: Int) -> String? {
        let isSectionView = tableView.delegate?.tableView?(tableView, viewForHeaderInSection: section) != nil
        return isSectionView ? nil : sections?[section].title
    }
    
    public func cell(from tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = sections?[indexPath.section].items?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier()) {
                item.configureCell(cell)
                return cell
            }
        }
        return UITableViewCell()
    }
}

//MARK: - Tappable

public let deselectRow: (UITableView, IndexPath) -> Void = { $0.deselectRow(at: $1, animated: true) }

extension FlexDataSourceProtocol {
    public func tappableOnSelect(_ tableView: UITableView, _ indexPath: IndexPath) -> Void {
        deselectRow(tableView, indexPath)
        if let tappable = sections?[indexPath.section].items?[indexPath.row] as? Tappable {
            tappable.onTap()
        }
    }
    
    public func itemTapOnSelect(onTap: @escaping (FlexDataSourceItem) -> Void) -> (UITableView, IndexPath) -> Void {
        return { tableView, indexPath in
            deselectRow(tableView, indexPath)
            if let item = self.sections?[indexPath.section].items?[indexPath.row] {
                onTap(item)
            }
        }
    }
}

//MARK: - Swiping

extension FlexDataSourceProtocol {
    public func canEditRow(in tableView: UITableView, at indexPath: IndexPath) -> Bool {
        if let _ = sections?[indexPath.section].items?[indexPath.row] as? Swipable {
            return true
        }
        return false
    }
    
    public func commitEditingStyleForRow(_ tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, at indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = sections?[indexPath.section].items?[indexPath.row] as? Swipable {
                item.onSwipe()
                sections?[indexPath.section].items?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

//MARK: - Item Access
extension FlexDataSourceProtocol {
    public func item(at indexPath: IndexPath) -> FlexDataSourceItem? {
        return sections?[indexPath.section].items?[indexPath.row]
    }
}
