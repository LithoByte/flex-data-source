//
//  FlexDataSourceItemTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import LithoOperators
@testable import FlexDataSource

class FlexDataSourceItemTests: XCTestCase {
    
    class TestConcreteFlexDataSource<T>: ConcreteFlexDataSourceItem<T> where T: UITableViewCell {
        
        var configureUICell: (UITableViewCell) -> Void
        
        init(identifier: String = "cell", _ configureCell: @escaping (UITableViewCell) -> Void) {
            self.configureUICell = configureCell
            super.init(identifier: identifier)
        }
        
    override func configureCell(_ cell: UITableViewCell) {
            return configureUICell(cell)
        }
    }

    func testFunctionalFlexDataSourceItem() {
        let identifier = "TableViewCell"
        let item = FunctionalFlexDataSourceItem<UITableViewCell>(identifier: identifier, set(\UITableViewCell.backgroundColor, .red))
        let cell = UITableViewCell()
        item.configureCell(cell)
        XCTAssertEqual(cell.backgroundColor, .red)
        XCTAssertEqual(item.cellIdentifier(), identifier)
    }
    
    func testConcreteFlexDataSourceItem() {
        let cellID = "ConcreteCell"
        let item = TestConcreteFlexDataSource(identifier: cellID, set(\UITableViewCell.backgroundColor, .blue))
        let cell = UITableViewCell()
        item.configureCell(cell)
        XCTAssertEqual(cell.backgroundColor, .blue)
        XCTAssertEqual(item.cellIdentifier(), cellID)
    }
    
    func testTappableFlexDataSourceItem() {
        var pressed = false
        let cellID = "Tappable"
        let cell = UITableViewCell()
        let item = TappableFunctionalFlexItem<UITableViewCell>(identifier: cellID, set(\UITableViewCell.backgroundColor, .red)) {
            pressed = true
        }
        item.configureCell(cell)
        item.onTap()
        XCTAssertEqual(cell.backgroundColor, .red)
        XCTAssertEqual(item.cellIdentifier(), cellID)
        XCTAssertTrue(pressed)
    }
    
    func testSwipableFlexDataSourceItem() {
        var wasSwiped = false
        var wasTapped = false
        let cellID = "Swipable"
        let cell = UITableViewCell()
        let item = SwipableItem<UITableViewCell>(identifier: cellID, set(\UITableViewCell.backgroundColor, .blue), { wasTapped = true }, {wasSwiped = true})
        item.configureCell(cell)
        item.onTap()
        item.onSwipe()
        XCTAssertEqual(cell.backgroundColor, .blue)
        XCTAssertEqual(item.cellIdentifier(), cellID)
        XCTAssertTrue(wasSwiped == true)
        XCTAssertTrue(wasTapped == true)
    }
}
