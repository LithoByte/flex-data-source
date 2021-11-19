//
//  FlexTitledDataSourceTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import LithoOperators
@testable import FlexDataSource


class FlexTitledDataSourceTests: XCTestCase {
    
    func testTitleForHeaderIn() {
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let flexSection2 = FlexDataSourceSection(title: title2, items: array2)
        let flexSection3 = FlexDataSourceSection(title: title3, items: array3)
        let sectionArray = [flexSection1, flexSection2, flexSection3]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        let dataSource = FlexTitledDataSource(tableView, sectionArray)
        let titleFound1 = dataSource.titleForHeader(on: tableView, inSection: 0)
        let titleFound2 = dataSource.titleForHeader(on: tableView, inSection: 2)
        let titleFound3 = dataSource.titleForHeader(on: tableView, inSection: 1)
        XCTAssertEqual(titleFound1, title1)
        XCTAssertEqual(titleFound2, title3)
        XCTAssertEqual(titleFound3, title2)
    }
}
