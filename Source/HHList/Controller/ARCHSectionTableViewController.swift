//
//  ARCHSectionTableViewController.swift
//  HHModuleDemo
//
//  Created by basalaev on 12/12/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

open class ARCHSectionTableViewController<D: Hashable, VM: ARCHSectionViewModel>: NSObject {

    public let viewDataSource: ARCHTableViewDataSource
    public let dataAdapter: ARCHSectionListDataAdapter<D, VM>

    public var updateDataBlock: (([D]) -> Void)?

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
        }
        get {
            return viewDataSource.dataSource
        }
    }

    // MARK: - Initialize

    public init(
        dataSource: ARCHTableViewDataSource,
        dataAdapter: ARCHSectionListDataAdapter<D, VM>
        ) {

        VM.headerTypes.forEach { info in
            if let headerType = info.0 as? UITableViewHeaderFooterView.Type {
                dataSource.register(header: headerType, for: info.1)
            }
        }

        VM.footerTypes.forEach { info in
            if let footerType = info.0 as? UITableViewHeaderFooterView.Type {
                dataSource.register(footer: footerType, for: info.1)
            }
        }

        VM.cellViewModels.forEach { info in
            if let cellType = info.0 as? UITableViewCell.Type {
                dataSource.register(cell: cellType, for: info.1)
            }
        }

        dataSource.dataAdapter = dataAdapter
        self.viewDataSource = dataSource
        self.dataAdapter = dataAdapter

        super.init()

        updateDataBlock = { [weak self] data in
            self?.dataAdapter.data = data
            self?.tableView.reloadData()
        }
    }

    convenience public init(
        tableView: UITableView = UITableView(frame: .zero),
        mapBlock: @escaping (D) -> VM?
        ) {

        let dataSource = ARCHTableViewDataSource(view: tableView)
        let dataAdapter = ARCHSectionListDataAdapter<D, VM>(map: mapBlock)
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
