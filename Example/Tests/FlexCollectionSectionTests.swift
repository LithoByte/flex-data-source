//
//  FlexCollectionSectionTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import LithoOperators
@testable import FlexDataSource

class FlexCollectionSectionTests: XCTestCase {

    func testTitle() {
        let title = "Section Testing"
        let flexSection = FlexCollectionSection(title: title, items: nil)
        // make sure the title is the one passed into the constructor
        XCTAssertEqual(flexSection.title!, title)
    }
    
    func testItems() {
        // make sure the items are properly transferred into the section
        let title = "Section Testing"
        let type = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "Test")
        let type2 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "Test2")
        let type3 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "Test3")
        let array: [FlexCollectionItem]? = [type, type2, type3]
        let flexSection = FlexCollectionSection(title: title, items: array)
        XCTAssertEqual(flexSection.title, title)
        XCTAssertTrue(flexSection.items != nil)
        XCTAssertEqual(flexSection.items?.count, 3)
    }
    
    func testCollectionItemsToSection() {
        let item1 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "1")
        let item2 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "2")
        let item3 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "3")
        let array: [FlexCollectionItem] = [item1, item2, item3]
        let arrayTest = collectionItemsToSection(items: array)
        XCTAssertTrue(arrayTest.items != nil)
        XCTAssertTrue(arrayTest.items?.count == 3)
        // make sure that a call to this method accurately creates a FlexDataSourceSection from a list of Items
    }
    
    func testSectionsToDataSource() {
        let flexSection1 = FlexCollectionSection(title: collectionTitle1, items: collectionArray1)
        let flexSection2 = FlexCollectionSection(title: collectionTitle2, items: collectionArray2)
        let flexSection3 = FlexCollectionSection(title: collectionTitle3, items: collectionArray3)
        let sectionArray = [flexSection1, flexSection2, flexSection3]
        let test = collectionSectionsToDataSource(sections: sectionArray)
        XCTAssertTrue(test.sections?.count != nil)
        XCTAssertTrue(test.sections?.count == 3)
        XCTAssertTrue(test.sections?.first?.title == title1)
        XCTAssertTrue(test.sections?.last?.title == title3)
        XCTAssertTrue((test.sections?.contains(flexSection2)) != nil)
        // make sure that a call to this method accurately creates a FlexDataSource from a list of sections
    }
}
let collectionTitle1 = "First Section"
let collectionTitle2 = "Second Section"
let collectionTitle3 = "Third Section"
let collectionType1 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "1")
let collectionType2 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "2")
let collectionType3 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "3")
let collectionType4 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "4")
let collectionType5 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "5")
let collectionType6 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "6")
let collectionType7 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "7")
let collectionType8 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "8")
let collectionType9 = ConcreteFlexCollectionItem<UICollectionViewCell>(identifier: "9")
let collectionArray1 = [collectionType1, collectionType2, collectionType3]
let collectionArray2 = [collectionType4, collectionType5, collectionType6]
let collectionArray3 = [collectionType7, collectionType8, collectionType9]
