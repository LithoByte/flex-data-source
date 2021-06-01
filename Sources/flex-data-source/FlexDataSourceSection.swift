//
//  FlexDataSourceSection.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

open class FlexDataSourceSection: NSObject {
    open var title: String?
    open var items: [FlexDataSourceItem]?
    
    public init(title: String? = nil, items: [FlexDataSourceItem]? = nil) {
        self.title = title
        self.items = items
    }
}

public func itemsToSection(items: [FlexDataSourceItem]) -> FlexDataSourceSection {
    return FlexDataSourceSection(items: items)
}

public func sectionsToDataSource(sections: [FlexDataSourceSection]?) -> FlexDataSource {
    let ds = FlexDataSource()
    ds.sections = sections
    return ds
}
