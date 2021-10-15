//
//  FlexSimpleDataSourceTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest

class FlexDataSourceTests: XCTestCase {
    // look at FlexSimpleDataSource and FlexDataSourceProtocol
    
    func testTitleForHeaderIn() {
        // test the titleForHeaderIn method with a titled FlexDataSourceSection
    }
    
    // testConfigureCell
    func testConfigureCell() {
        // make a FlexDataSource with one item and one section, and call the cell(tableView, forRowAt) method, verify cell was configured (set the background color, for example)
    }
    
    func testTappableOnSelect() {
        // make a FlexDataSource with one section and one item, that is a TappableFlexDataSourceItem. Use tappableOnSelect to 'tap' the indexPath of the item (Section 0, row 0) and verify that the onTap function was called
    }
    
    func testItemTapOnSelect() {
        // repeat procedure above, use itemTapOnSelect (pass in a method that ignores the item and changes a local variable) and test on the indexPath used for the above test
    }
    
    func testCanEditRow() {
        // use a SwipableFlexDataSourceItem and a TappableFlexDataSourceItem in a FlexDataSource, and test to make sure the canEditRow method returns true for the Swipable, false for the non-Swipable
    }
    
    func testItemAt() {
        // test the item at method to make sure the method produces the right item for the given indexPath
    }
}
