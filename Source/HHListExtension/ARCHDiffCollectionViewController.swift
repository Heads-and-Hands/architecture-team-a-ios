//
//  ARCHDiffCollectionViewController.swift
//  ListExtension
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHList
import DeepDiff

// swiftlint:disable:next line_length
public class ARCHDiffCollectionViewController<D: Hashable, VM: ARCHCellViewModel & ARCHModelInitilizable, C: UICollectionViewCell & ARCHCell>: ARCHCollectionViewController<D, VM, C> {

    // MARK: - Data

    override public func didSet(data: [D]) {
        if UIView.areAnimationsEnabled, !collectionView.isHidden {
            let changes = diff(old: dataAdapter.data, new: data)
            reloadViewWith(data: data, changes: changes)
        } else {
            dataAdapter.data = data
            collectionView.reloadData()
        }
    }

    private func reloadViewWith(data: [D], changes: [Change<D>]) {
        let changesWithIndexPath = IndexPathConverter().convert(changes: changes, section: 0)

        collectionView.performBatchUpdates({
            dataAdapter.data = data
            internalBatchUpdates(changesWithIndexPath: changesWithIndexPath)
        }, completion: nil)
    }

    private func internalBatchUpdates(changesWithIndexPath: ChangeWithIndexPath) {
        changesWithIndexPath.deletes.executeIfPresent {
            self.collectionView.deleteItems(at: $0)
        }

        changesWithIndexPath.inserts.executeIfPresent {
            self.collectionView.insertItems(at: $0)
        }

        changesWithIndexPath.moves.executeIfPresent {
            $0.forEach { move in
                self.collectionView.moveItem(at: move.from, to: move.to)
            }
        }

        changesWithIndexPath.replaces.executeIfPresent {
            self.collectionView.reloadItems(at: $0)
        }
    }
}
