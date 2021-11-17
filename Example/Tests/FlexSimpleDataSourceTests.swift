//
//  FlexSimpleDataSourceTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import FlexDataSource
import LithoOperators


class FlexDataSourceTests: XCTestCase {
    // look at FlexSimpleDataSource and FlexDataSourceProtocol
    
    
    class TestFunctionalFlexDataSourceItem<T>: FunctionalFlexDataSourceItem<T> where T: UITableViewCell {
        
        var configureUICell: (UITableViewCell) -> Void
        
        override init(identifier: String = "cell", _ configureCell: @escaping (UITableViewCell) -> Void) {
            self.configureUICell = configureCell
            super.init(identifier: identifier, configureCell)
        }
        
    override func configureCell(_ cell: UITableViewCell) {
            return configureUICell(cell)
        }
    }
  
    func testTitleForHeader() {
        // test the titleForHeaderIn method with a titled FlexDataSourceSection
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let flexSection2 = FlexDataSourceSection(title: title2, items: array2)
        let flexSection3 = FlexDataSourceSection(title: title3, items: array3)
        let sectionArray = [flexSection1, flexSection2, flexSection3]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        let dataSource = FlexDataSource(tableView, sectionArray)
        XCTAssertEqual(dataSource.titleForHeader(on: tableView, inSection: 0), title1)
    }
    
    
    func testConfigureCell() {
//         make a FlexDataSource with one item and one section, and call the cell(tableView, forRowAt) method, verify cell was configured (set the background color, for example)
        let title1 = "First Section"
        let type1 = TestFunctionalFlexDataSourceItem<UITableViewCell>(identifier: "1", set(\UITableViewCell.backgroundColor, .green))
        let functionalCell = UITableViewCell()
        type1.configureCell(functionalCell)
        let array1 = [type1]
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let sectionArray = [flexSection1]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        let dataSource = FlexDataSource(tableView, sectionArray)
        let cell = dataSource.cell(from: tableView, forRowAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(cell.backgroundColor, .green)
//        XCTAssertEqual(dataSource.sections?.first?.items?.first as! UITableViewCell, cell)
    }
    
    func testTappableOnSelect() {
        // make a FlexDataSource with one section and one item, that is a TappableFlexDataSourceItem. Use tappableOnSelect to 'tap' the indexPath of the item (Section 0, row 0) and verify that the onTap function was called
        let title1 = "First Section"
        var wasTapped = false
        let type1 = TappableFunctionalFlexItem<UITableViewCell>(identifier: "1", { _ in }, { wasTapped = true })
        let array1 = [type1]
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let sectionArray = [flexSection1]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        let dataSource = FlexDataSource(tableView, sectionArray)
        dataSource.tappableOnSelect(tableView, IndexPath(item: 0, section: 0))
        XCTAssertTrue(wasTapped)
    }
    
    func testItemTapOnSelect() {
        // repeat procedure above, use itemTapOnSelect (pass in a method that ignores the item and changes a local variable) and test on the indexPath used for the above test
        let title1 = "First Section"
        var wasTapped = false
        let type1 = TappableFunctionalFlexItem<UITableViewCell>(identifier: "1", { _ in }, { wasTapped = true })
        let array1 = [type1]
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let sectionArray = [flexSection1]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        let dataSource = FlexDataSource(tableView, sectionArray)
        let onTap = dataSource.itemTapOnSelect(onTap: ignoreArg({ wasTapped = true }))
        onTap(tableView, IndexPath(item: 0, section: 0))
        XCTAssertTrue(wasTapped)
    }
    
    func testCanEditRow() {
        // use a SwipableFlexDataSourceItem and a TappableFlexDataSourceItem in a FlexDataSource, and test to make sure the canEditRow method returns true for the Swipable, false for the non-Swipable
        let title1 = "First Section"
        let title2 = "Second Section"
        var wasSwiped = false
        var swipableWasSwiped = false
        let type1 = TappableFunctionalFlexItem<UITableViewCell>(identifier: "1", { _ in }, { wasSwiped = false })
        let type2 = SwipableItem<UITableViewCell>(identifier: "2", { _ in }, { }, { swipableWasSwiped = true })
        let array1 = [type1]
        let array2 = [type2]
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let flexSection2 = FlexDataSourceSection(title: title2, items: array2)
        let sectionArray = [flexSection1, flexSection2]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        let dataSource = FlexDataSource(tableView, sectionArray)
        let ontap = dataSource.canEditRow(in: tableView, at: IndexPath(item: 0, section: 0))
        let onSwipe = dataSource.canEditRow(in: tableView, at: IndexPath(item: 0, section: 1))
        XCTAssertTrue(ontap == false)
        XCTAssertTrue(onSwipe)
        XCTAssertTrue(wasSwiped == false)
//        XCTAssertTrue(swipableWasSwiped)
        
    }
    
    func testItemAt() {
        // test the item at method to make sure the method produces the right item for the given indexPath
        let title1 = "First Section"
        let title2 = "Second Section"
        var wasTapped = false
        var wasSwiped = false
        let type1 = TappableFunctionalFlexItem<UITableViewCell>(identifier: "1", { _ in }, { wasTapped = true })
        let type2 = SwipableItem<UITableViewCell>(identifier: "2", { _ in }, { }, { wasSwiped = true })
        let array1 = [type1]
        let array2 = [type2]
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let flexSection2 = FlexDataSourceSection(title: title2, items: array2)
        let sectionArray = [flexSection1, flexSection2]
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        let dataSource = FlexDataSource(tableView, sectionArray)
        let firstItem = dataSource.item(at: IndexPath(item: 0, section: 0))
        let secondItem = dataSource.item(at: IndexPath(item: 0, section: 1))
        XCTAssertTrue(firstItem is TappableFunctionalFlexItem)
        XCTAssertTrue(secondItem is SwipableItem)
//        XCTAssertTrue(wasTapped)
//        XCTAssertTrue(wasSwiped)
    }
}

let title1 = "First Section"
let title2 = "Second Section"
let title3 = "Third Section"
let type1 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "1")
let type2 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "2")
let type3 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "3")
let type4 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "4")
let type5 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "5")
let type6 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "6")
let type7 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "7")
let type8 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "8")
let type9 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "9")
let array1 = [type1, type2, type3]
let array2 = [type4, type5, type6]
let array3 = [type7, type8, type9]
