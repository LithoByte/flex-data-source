//
//  FlexCollectionItemTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import LithoOperators
@testable import FlexDataSource

class FlexCollectionItemTests: XCTestCase {
    
    func testFunctionalFlexCollectionItem() {
        let identifier = "Cell"
        let item = FunctionalFlexCollectionItem<UICollectionViewCell>(identifier: identifier, set(\UICollectionViewCell.backgroundColor, .brown))
        let cell = UICollectionViewCell()
        item.configureCell(cell)
        XCTAssertEqual(cell.backgroundColor, .brown)
        XCTAssertEqual(item.cellIdentifier(), identifier)
    }
    
    func testConcreteFlexCollectionItem() {
        let cellID = "ConcreteCell"
        let item = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: cellID)
        let cell = UICollectionViewCell()
        cell.backgroundColor = .blue
        item.configureCell(cell)
        XCTAssertEqual(cell.backgroundColor, .blue)
        XCTAssertEqual(item.cellIdentifier(), cellID)
    }
    
    func testTappableFlexDataCollectionItem() {
        var pressed = false
        let cellID = "Tappable"
        let cell = UICollectionViewCell()
        let item = TappableFlexCollectionItem<UICollectionViewCell>(identifier: cellID, set(\UITableViewCell.backgroundColor, .red)) {
            pressed = true
        }
        item.configureCell(cell)
        item.onTap?()
        XCTAssertEqual(cell.backgroundColor, .red)
        XCTAssertEqual(item.cellIdentifier(), cellID)
        XCTAssertTrue(pressed == true)
    }
}
