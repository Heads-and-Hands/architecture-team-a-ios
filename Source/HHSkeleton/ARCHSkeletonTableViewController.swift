//
//  ARCHSkeletonTableViewController.swift
//  HHModuleDemo
//
//  Created by basalaev on 18.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public class ARCHSkeletonTableViewController<C: UITableViewCell & ARCHSkeletonView>: NSObject, UITableViewDataSource, ARCHSkeletonView {

    public let tableView: UITableView
    private let cellID = "Skeleton Cell ID"

    public var delegate: UITableViewDelegate? {
        set {
            tableView.delegate = newValue
        }
        get {
            return tableView.delegate
        }
    }

    public var dataSource: UITableViewDataSource?

    public init(tableView: UITableView = UITableView()) {
        self.tableView = tableView
        super.init()
        tableView.register(C.self, forCellReuseIdentifier: cellID)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            fatalError("Fail create skeleton cell")
        }

        return cell
    }

    // MARK: - ARCHSkeletonView

    public var skeletonSubviews: [UIView]? {
        return tableView.visibleCells
    }

    public func set(isEnableSkeleton: Bool) {
        tableView.dataSource = isEnableSkeleton ? self : dataSource
        tableView.reloadData()

        if isEnableSkeleton {
            tableView.visibleCells.forEach { cell in
                if let skeletonCell = cell as? ARCHSkeletonView {
                    skeletonCell.set(isEnableSkeleton: true)
                }
            }
        }
    }

    // MARK: - DataSource Proxy

    override open func responds(to aSelector: Selector!) -> Bool {
        if super.responds(to: aSelector) {
            return true
        }

        return dataSource?.responds(to: aSelector) ?? false
    }

    override open func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let dataSource = dataSource, dataSource.responds(to: aSelector) {
            return dataSource
        }

        return super.forwardingTarget(for: aSelector)
    }
}
