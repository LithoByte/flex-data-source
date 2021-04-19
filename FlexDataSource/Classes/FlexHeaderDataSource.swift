//
//  FlexHeaderDataSource.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 4/19/21.
//

import Foundation

open class FlexHeaderDataSource<T: FlexTableViewHeaderFooterView & UITableViewHeaderFooterView>: FlexUntitledDataSource {
    public var configureHeaderView: ((T, FlexDataSourceSection) -> Void)?
    open override func registerCells() {
        super.registerCells()
        let className = String(describing: T.headerClass())
        let bundle = Bundle(for: T.headerClass())
        if bundle.path(forResource: className, ofType: "nib") != nil {
            tableView?.register(UINib(nibName: className, bundle: bundle), forHeaderFooterViewReuseIdentifier: T.reuseIdentifier())
        } else {
            tableView?.register(T.headerClass(), forHeaderFooterViewReuseIdentifier: T.reuseIdentifier())
        }
    }
    
    public func viewForHeaderInSection(_ tableView: UITableView, inSection section: Int) -> T? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier()) as? T, let section = sections?[section] else { return nil }
        configureHeaderView?(view, section)
        return view
    }
}



public protocol FlexTableViewHeaderFooterView {
    static func reuseIdentifier() -> String
    static func headerClass() -> UITableViewHeaderFooterView.Type
}
