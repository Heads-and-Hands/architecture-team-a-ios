//
//  ARCHTableViewController.swift
//  ListExtension
//
//  Created by basalaev on 15.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHList
import DeepDiff

// swiftlint:disable:next line_length
public class ARCHTableViewController<D: Hashable, VM: ARCHCellViewModel & ARCHModelInitilizable, C: UITableViewCell & ARCHCell>: UIViewController {

    private let viewDataSource: ARCHTableViewDataSource
    private let dataAdapter: ARCHEmptyListDataAdapter<D, VM>

    public var insertionAnimation: UITableViewRowAnimation = .automatic
    public var deletionAnimation: UITableViewRowAnimation = .automatic
    public var replacementAnimation: UITableViewRowAnimation = .automatic

    public var delegate: ARCHListDataSourceDelegate? {
        set {
            viewDataSource.delegate = delegate
        }
        get {
            return viewDataSource.delegate
        }
    }

    public var dataSource: UITableViewDataSource? {
        set {
            viewDataSource.dataSource = dataSource
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

        super.init(nibName: nil, bundle: nil)
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

    override public func loadView() {
        view = tableView
    }

    // MARK: - Data

    public var data: [D] = [] {
        didSet {
            let changes = diff(old: dataAdapter.data, new: data)
            reloadViewWith(data: data, changes: changes)
        }
    }

    private func reloadViewWith(data: [D], changes: [Change<D>]) {
        let changesWithIndexPath = IndexPathConverter().convert(changes: changes, section: 0)

        if #available(iOS 11, tvOS 11, *) {
            tableView.performBatchUpdates({
                dataAdapter.data = data
                internalBatchUpdates(changesWithIndexPath: changesWithIndexPath)
            }, completion: nil)
        } else {
            tableView.beginUpdates()
            dataAdapter.data = data
            internalBatchUpdates(changesWithIndexPath: changesWithIndexPath)
            tableView.endUpdates()
        }
    }

    private func internalBatchUpdates(changesWithIndexPath: ChangeWithIndexPath) {
        changesWithIndexPath.deletes.executeIfPresent {
            tableView.deleteRows(at: $0, with: deletionAnimation)
        }

        changesWithIndexPath.inserts.executeIfPresent {
            tableView.insertRows(at: $0, with: insertionAnimation)
        }

        changesWithIndexPath.moves.executeIfPresent {
            $0.forEach { move in
                tableView.moveRow(at: move.from, to: move.to)
            }
        }

        changesWithIndexPath.replaces.executeIfPresent {
            tableView.reloadRows(at: $0, with: replacementAnimation)
        }
    }
}
