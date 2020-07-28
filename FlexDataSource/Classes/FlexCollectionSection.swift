//
//  FlexCollectionSection.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 7/27/20.
//

import UIKit

open class FlexCollectionSection: NSObject {
    open var title: String?
    open var items: [FlexCollectionItem]?
    
    public init(title: String? = nil, items: [FlexCollectionItem]? = nil) {
        self.title = title
        self.items = items
    }
}

public func itemsToSection(items: [FlexCollectionItem]) -> FlexCollectionSection {
    return FlexCollectionSection(items: items)
}

public func sectionsToDataSource(sections: [FlexCollectionSection]?) -> FlexCollectionDataSource {
    let ds = FlexCollectionDataSource()
    ds.sections = sections
    return ds
}
