//
//  ViewController.swift
//  FlexDataSource
//
//  Created by Elliot on 03/27/2020.
//  Copyright (c) 2020 Elliot. All rights reserved.
//

import UIKit
import FlexDataSource
import fuikit

class ViewController: UIViewController {
    var tableView: UITableView!
    
    var numbers: [Int] = [Int]()
    let dataSource = FlexHeaderDataSource<TableViewHeader>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        numbers.append(contentsOf: 1...17)
        tableView.sectionHeaderHeight = 60
        tableView.estimatedSectionHeaderHeight = 60
        let delegate = FUITableViewDelegate()
        let items = numbers.map { NumberItem(value: $0) }
        let section = FlexDataSourceSection(title: "Numbers")
        section.items = items
        dataSource.tableView = tableView
        dataSource.configureHeaderView = {
            $0.title.text = $1.title
        }
        delegate.onViewForHeaderInSection = dataSource.viewForHeaderInSection
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        dataSource.sections = [section]
        tableView.reloadData()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        super.loadView()
    }
}
class NumberItem: ConcreteFlexDataSourceItem<UITableViewCell> {
    let value: Int
    init(identifier: String = "cell", value: Int) {
        self.value = value
        super.init(identifier: identifier)
    }
    
    override func configureCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = "\(value)"
    }
}
