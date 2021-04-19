//
//  Array+Flex.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 8/11/20.
//

import Foundation

public extension Array where Element: FlexDataSourceItem {
    func flexDataSource() -> FlexUntitledDataSource {
        let ds = FlexUntitledDataSource()
        let section = FlexDataSourceSection(title: nil, items: self)
        ds.sections = [section]
        return ds
    }
}

public extension Array where Element: FlexCollectionItem {
    func flexCollectionDataSource() -> FlexCollectionDataSource {
        let ds = FlexCollectionDataSource()
        let section = FlexCollectionSection(title: nil, items: self)
        ds.sections = [section]
        return ds
    }
}
