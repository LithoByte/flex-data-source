//
//  FlexCollectionDataSource.swift
//  FlexDataSource
//
//  Created by Elliot Schrock on 7/27/20.
//

import UIKit

open class FlexCollectionDataSource: NSObject, UICollectionViewDataSource {
    public var collectionView: UICollectionView? {
        didSet {
            registerCells()
            collectionView?.dataSource = self
        }
    }
    public var sections: [FlexCollectionSection]? {
        didSet {
            registerCells()
        }
    }
    
    open func registerCells() {
        if let sections = self.sections, let  collectionView = self.collectionView {
            for section in sections {
                if let items = section.items {
                    for item in items {
                        let className = String(describing: item.cellClass())
                        let bundle = Bundle(for: item.cellClass())
                        if bundle.path(forResource: className, ofType: "nib") != nil {
                            collectionView.register(UINib(nibName: className, bundle: bundle), forCellWithReuseIdentifier: item.cellIdentifier())
                        } else {
                            collectionView.register(item.cellClass(), forCellWithReuseIdentifier: item.cellIdentifier())
                        }
                    }
                }
            }
        }
    }
    
    // MARK: CollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections?[section].items?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = sections?[indexPath.section].items?[indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier(), for: indexPath)
            item.configureCell(cell)
            return cell
        }
        return UICollectionViewCell()
    }
}
