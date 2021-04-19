//
//  FlexTitledDataSource.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 4/19/21.
//

import Foundation

open class FlexTitledDataSource: FlexUntitledDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return onTitleForHeaderInSection(tableView, section)
    }
}
