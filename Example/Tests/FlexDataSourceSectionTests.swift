//
//  FlexDataSourceSectionTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import FlexDataSource

class FlexDataSourceSectionTests: XCTestCase {
    // look at FlexDataSourceSection and test the methods therein
    func testTitle() {
        let title = "Section Testing"
        let flexSection = FlexDataSourceSection(title: title, items: nil)
        // make sure the title is the one passed into the constructor
        XCTAssertEqual(flexSection.title!, title)
    }
    
    func testItems() {
        // make sure the items are properly transferred into the section
        let title = "Section Testing"
        let type = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "Test")
        let type2 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "Test2")
        let type3 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "Test3")
        let array: [FlexDataSourceItem]? = [type, type2, type3]
        let flexSection = FlexDataSourceSection(title: title, items: array)
        XCTAssertEqual(flexSection.title, title)
        XCTAssertTrue(flexSection.items != nil)
        XCTAssertEqual(flexSection.items?.count, 3)
    }
    
    func testItemsToSection() {
        let title = "Items to Section"
        let item1 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "1")
        let item2 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "2")
        let item3 = ConcreteFlexDataSourceItem<UITableViewCell>(identifier: "3")
        let array: [FlexDataSourceItem] = [item1, item2, item3]
        itemsToSection(items: array)
        itemsToSection(items: array).title = title
        XCTAssertTrue(itemsToSection(items: array).items?.count == 3)
        XCTAssertTrue(itemsToSection(items: array).items != nil)
        // make sure that a call to this method accurately creates a FlexDataSourceSection from a list of Items
    }
    
    func testSectionsToDataSource() {
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
        let flexSection1 = FlexDataSourceSection(title: title1, items: array1)
        let flexSection2 = FlexDataSourceSection(title: title2, items: array2)
        let flexSection3 = FlexDataSourceSection(title: title3, items: array3)
        let sectionArray = [flexSection1, flexSection2, flexSection3]
        let test = sectionsToDataSource(sections: sectionArray)
        XCTAssertTrue(test.sections?.count != nil)
        XCTAssertTrue(test.sections?.count == 3)
        XCTAssertTrue(test.sections?.first?.title == title1)
        XCTAssertTrue(test.sections?.last?.title == title3)
        // make sure that a call to this method accurately creates a FlexDataSource from a list of sections
    }
}
