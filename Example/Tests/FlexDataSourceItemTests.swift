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
    // go to FlexDataSourceItems and take a look. We want test all configureCell functions to make sure call what we pass into the constructors ex:
    
    
    func testFunctionalFlexDataSourceItem() {
        let identifier = "TableViewCell"
        let item = FunctionalFlexDataSourceItem<UITableViewCell>(identifier: identifier, set(\UITableViewCell.backgroundColor, .red))
        let cell = UITableViewCell()
        item.configureCell(cell)
        XCTAssertEqual(cell.backgroundColor, .red)
        XCTAssertEqual(item.cellIdentifier(), identifier)
    }
    
    func testConcreteFlexDataSourceItem() {
        // you will have to subclass this class and override the configureCell method
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
        XCTAssertTrue(pressed == true)
        // pass a closure to change this value in the constructor, make sure is true after calling onTap
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
        
        // repeat for onSwipe
    }
}
