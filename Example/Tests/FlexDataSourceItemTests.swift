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
    // go to FlexDataSourceItems and take a look. We want test all configureCell functions to make sure call what we pass into the constructors ex:
    
    func testFunctionalFlexDataSourceItem() {
        let identifier = "TableViewCell"
        let item = FunctionalFlexDataSourceItem<UITableViewCell>(set(\UITableViewCell.backgroundColor, .red))
        let cell = UITableViewCell()
        item.configureCell(cell)
        XCTAssertEqual(cell.backgroundColor, .red)
        XCTAssertEqual(item.cellIdentifier(), identifier)
    }
    
    func testConcreteFlexDataSourceItem() {
        // you will have to subclass this class and override the configureCell method
    }
    
    func testTappableFlexDataSourceItem() {
        var wasTapped = false
        // pass a closure to change this value in the constructor, make sure is true after calling onTap
    }
    
    func testSwipableFlexDataSourceItem() {
        var wasSwiped = false
        // repeat for onSwipe
    }
}
