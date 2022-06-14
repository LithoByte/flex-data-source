//
//  FlexItemsTests.swift
//  FlexDataSource_Tests
//
//  Created by Calvin Collins on 10/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import Foundation
@testable import FlexDataSource
import LithoOperators
import Prelude

private struct Human {
    var id: Int?
    var name: String?
}

class FlexItemTests: XCTestCase {
    func testFlexModelItem() {
        let setMainLabel: (Human, UITableViewCell) -> Void = {
            $1.detailTextLabel?.text = $0.name
        }
        let configurer: (Human, UITableViewCell) -> Void = setMainLabel
        let item = FlexModelItem<Human, UITableViewCell>(Human(id: 123, name: "Calvin Collins"), configurer)
        item.configureCell(UITableViewCell())
    }
    
    func testFlexTappable() {
        let setMainLabel: (Human, UITableViewCell) -> Void = {
            $1.detailTextLabel?.text = $0.name
        }
        let configurer: (Human, UITableViewCell) -> Void = setMainLabel
        var wasTapped: Bool = false
        let item = FlexModelItem<Human, UITableViewCell>(model: Human(id: 123, name: "Calvin Collins"), configurer: configurer, tap: { _ in
            wasTapped = true
        })
        item.onTap?()
        XCTAssert(wasTapped)
    }
    
    func testFlexSwipe() {
        let setMainLabel: (Human, UITableViewCell) -> Void = {
            $1.detailTextLabel?.text = $0.name
        }
        let configurer: (Human, UITableViewCell) -> Void = setMainLabel
        var wasSwiped: Bool = false
        var wasTapped: Bool = false
        let item = FlexModelItem<Human, UITableViewCell>(model: Human(id: 123, name: "Calvin Collins"), configurer: configurer, tap: { _ in
                wasTapped = true
        }, swipe: { _ in
            wasSwiped = true
        })
        item.onSwipe?()
        item.onTap?()
        XCTAssert(wasTapped && wasSwiped)
    }
}
