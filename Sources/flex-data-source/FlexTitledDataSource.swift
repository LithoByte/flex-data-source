//
//  FlexTitledDataSource.swift
//  FlexDataSource
//
//  Created by Calvin Collins on 4/19/21.
//

import UIKit

open class FlexTitledDataSource: FlexDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return onTitleForHeaderInSection(tableView, section)
    }
}
