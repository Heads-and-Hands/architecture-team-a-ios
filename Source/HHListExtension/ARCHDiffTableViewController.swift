//
//  ARCHDiffTableViewController.swift
//  HHList
//
//  Created by basalaev on 05.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList
import DeepDiff

// swiftlint:disable:next line_length
public class ARCHDiffTableViewController<D: Hashable, VM: ARCHCellViewModel & ARCHModelInitilizable, C: UITableViewCell & ARCHCell>: ARCHTableViewController<D, VM, C> {

    public var insertionAnimation: UITableViewRowAnimation = .automatic
    public var deletionAnimation: UITableViewRowAnimation = .automatic
    public var replacementAnimation: UITableViewRowAnimation = .automatic

    override public func didSet(data: [D]) {
        if UIView.areAnimationsEnabled, !tableView.isHidden {
            let changes = diff(old: dataAdapter.data, new: data)
            reloadViewWith(data: data, changes: changes)
        } else {
            dataAdapter.data = data
            tableView.reloadData()
        }
    }

    // MARK: - Private

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
