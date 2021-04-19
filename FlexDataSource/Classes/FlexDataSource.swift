//
//  FlexDataSource.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 4/19/21.
//

import Foundation
import fuikit

public protocol FlexDataSource {
    func registerCells()
    func titleForHeader(on tableView: UITableView, inSection section: Int) -> String?
    func cell(from tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    func tappableOnSelect(_ tableView: UITableView, _ indexPath: IndexPath) -> Void
    func itemTapOnSelect(onTap: @escaping (FlexDataSourceItem) -> Void) -> (UITableView, IndexPath) -> Void
    func canEditRow(in tableView: UITableView, at indexPath: IndexPath) -> Bool
    func commitEditingStyleForRow(_ tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, at indexPath: IndexPath)
}
