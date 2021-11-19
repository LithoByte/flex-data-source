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
    // repeat the tests performed for FlexDataSourceItem with their analogous FlexCollectionItem
    class TestConcreteFlexCollectionItem<T>: ConcreteFlexCollectionItem<T> where T: UICollectionViewCell {
        
        var configureUICell: (UICollectionViewCell) -> Void
        
        init(identifier: String = "cell", _ configureCell: @escaping (UICollectionViewCell) -> Void) {
            self.configureUICell = configureCell
            super.init(identifier: identifier)
        }
        
        override func configureCell(_ cell: UICollectionViewCell) {
            return configureUICell(cell)
        }
    }
    
    func testFunctionalFlexCollectionItem() {
        let identifier = "Cell"
        let item = FunctionalFlexCollectionItem<UICollectionViewCell>(identifier: identifier, set(\UICollectionViewCell.backgroundColor, .brown))
        let cell = UICollectionViewCell()
        item.configureCell(cell)
        XCTAssertEqual(cell.backgroundColor, .brown)
        XCTAssertEqual(item.cellIdentifier(), identifier)
    }
    
    func testConcreteFlexCollectionItem() {
        // you will have to subclass this class and override the configureCell method
        let cellID = "ConcreteCell"
        let item = TestConcreteFlexCollectionItem<UICollectionViewCell>(identifier: cellID, set(\UITableViewCell.backgroundColor, .blue))
        let cell = UICollectionViewCell()
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
        item.onTap()
        XCTAssertEqual(cell.backgroundColor, .red)
        XCTAssertEqual(item.cellIdentifier(), cellID)
        XCTAssertTrue(pressed == true)
        // pass a closure to change this value in the constructor, make sure is true after calling onTap
    }
}
