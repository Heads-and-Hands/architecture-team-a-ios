//
//  ARCHTableViewController.swift
//  ListExtension
//
//  Created by basalaev on 15.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHTableViewController<D: Hashable, VM: ARCHCellViewModel & ARCHModelInitilizable, C: UITableViewCell & ARCHCell>: NSObject {

    public let viewDataSource: ARCHTableViewDataSource
    public let dataAdapter: ARCHEmptyListDataAdapter<D, VM>

    public var delegate: ARCHListDataSourceDelegate? {
        set {
            viewDataSource.delegate = newValue
        }
        get {
            return viewDataSource.delegate
        }
    }

    public var dataSource: UITableViewDataSource? {
        set {
            viewDataSource.dataSource = newValue
//            viewDataSource.refreshViewDataSource()
        }
        get {
            return viewDataSource.dataSource
        }
    }

    // MARK: - Initialize

    public init(
        dataSource: ARCHTableViewDataSource,
        dataAdapter: ARCHEmptyListDataAdapter<D, VM>
        ) {

        dataSource.register(cell: C.self, for: VM.self)
        dataSource.dataAdapter = dataAdapter

        self.viewDataSource = dataSource
        self.dataAdapter = dataAdapter

        super.init()
    }

    convenience public init(
        tableView: UITableView = UITableView()
        ) {

        let dataSource = ARCHTableViewDataSource(view: tableView)
        let dataAdapter = ARCHEmptyListDataAdapter<D, VM>()
        self.init(dataSource: dataSource, dataAdapter: dataAdapter)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View

    public var tableView: UITableView {
        return viewDataSource.view
    }

    // MARK: - Data

    public var data: [D] = [] {
        didSet {
            didSet(data: data)
        }
    }

    open func didSet(data: [D]) {
        dataAdapter.data = data
        tableView.reloadData()
    }
}
