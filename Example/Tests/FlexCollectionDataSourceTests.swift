//
//  FlexCollectionDataSourceTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import LithoOperators
@testable import FlexDataSource

class FlexCollectionDataSourceTests: XCTestCase {

    func testNumberOfCollectionSections() {
        let flexSection1 = FlexCollectionSection(title: collectionTitle1, items: collectionArray1)
        let flexSection2 = FlexCollectionSection(title: collectionTitle2, items: collectionArray2)
        let flexSection3 = FlexCollectionSection(title: collectionTitle3, items: collectionArray3)
        let sectionArray = [flexSection1, flexSection2, flexSection3]
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = FlexCollectionDataSource(collectionView, sectionArray)
        let sectionData = dataSource.numberOfSections(in: collectionView)
        XCTAssertEqual(sectionData, 3)
    }
    
    func testNumberOfSectionsIn() {
        let flexSection1 = FlexCollectionSection(title: collectionTitle1, items: collectionArray1)
        let flexSection2 = FlexCollectionSection(title: collectionTitle2, items: collectionArray2)
        let flexSection3 = FlexCollectionSection(title: collectionTitle3, items: collectionArray3)
        let sectionArray = [flexSection1, flexSection2, flexSection3]
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = FlexCollectionDataSource(collectionView, sectionArray)
        let collectionData = dataSource.collectionView(collectionView, numberOfItemsInSection: 1)
        XCTAssertEqual(collectionData, 3)
    }
    
    func testCellForItemAt() {
        let collectionItem = FunctionalFlexCollectionItem<UICollectionViewCell>(identifier: "1", set(\UICollectionViewCell.backgroundColor, .green))
        let flexSection1 = FlexCollectionSection(title: collectionTitle1, items: [collectionItem])
        let sectionArray = [flexSection1]
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = FlexCollectionDataSource(collectionView, sectionArray)
        dataSource.registerCells()
        let cell = dataSource.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(cell.backgroundColor, .green)
    }
    
    func testTappableOnSelect() {
        let title1 = "First Section"
        var wasTapped = false
        let type1 = TappableFlexCollectionItem<UICollectionViewCell>(identifier: "1", { _ in }, { wasTapped = true })
        let array1 = [type1]
        let flexSection1 = FlexCollectionSection(title: title1, items: array1)
        let sectionArray = [flexSection1]
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = FlexCollectionDataSource(collectionView, sectionArray)
        dataSource.tappableOnSelect(collectionView, IndexPath(item: 0, section: 0))
        XCTAssertTrue(wasTapped)
    }
    
    func testItemTapOnSelect() {
        let title1 = "First Section"
        var wasTapped = false
        let type1 = TappableFlexCollectionItem<UICollectionViewCell>(identifier: "1", { _ in }, { wasTapped = true })
        let array1 = [type1]
        let flexSection1 = FlexCollectionSection(title: title1, items: array1)
        let sectionArray = [flexSection1]
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = FlexCollectionDataSource(collectionView, sectionArray)
        let onTap = dataSource.itemTapOnSelect(onTap: ignoreArg({ wasTapped = true }))
        onTap(collectionView, IndexPath(item: 0, section: 0))
        XCTAssertTrue(wasTapped)
    }
    
}
