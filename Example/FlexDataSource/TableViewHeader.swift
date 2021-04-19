//
//  TableViewHeader.swift
//  FlexDataSource_Example
//
//  Created by Calvin Collins on 4/19/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import FlexDataSource

class TableViewHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() {
        contentView.backgroundColor = .red
        title.frame = CGRect(x: 20, y: 10, width: contentView.frame.width - 40, height: 20)
        title.textColor = .white
    }
}

extension TableViewHeader: FlexTableViewHeaderFooterView {
    static func reuseIdentifier() -> String {
        return "header"
    }
    
    static func headerClass() -> UITableViewHeaderFooterView.Type {
        return Self.self
    }
}
