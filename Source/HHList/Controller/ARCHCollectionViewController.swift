//
//  ARCHCollectionViewController.swift
//  ListExtension
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

// swiftlint:disable:next line_length
open class ARCHCollectionViewController<D: Hashable, VM: ARCHCellViewModel & ARCHModelInitilizable, C: UICollectionViewCell & ARCHCell>: NSObject {

    public let viewDataSource: ARCHCollectionViewDataSource
    public let dataAdapter: ARCHEmptyListDataAdapter<D, VM>

    public var updateDataBlock: (([D]) -> Void)?

    public var delegate: ARCHListDataSourceDelegate? {
        set {
            viewDataSource.delegate = newValue
        }
        get {
            return viewDataSource.delegate
        }
    }

    public var dataSource: UICollectionViewDataSource? {
        set {
            viewDataSource.dataSource = newValue
        }
        get {
            return viewDataSource.dataSource
        }
    }

    // MARK: - Initialize

    public init(
        dataSource: ARCHCollectionViewDataSource,
        dataAdapter: ARCHEmptyListDataAdapter<D, VM>
        ) {

        dataSource.register(cell: C.self, for: VM.self)
        dataSource.dataAdapter = dataAdapter

        self.viewDataSource = dataSource
        self.dataAdapter = dataAdapter

        super.init()

        updateDataBlock = { [weak self] data in
            self?.dataAdapter.data = data
            self?.collectionView.reloadData()
        }
    }

    convenience public init(
        collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        ) {

        let dataSource = ARCHCollectionViewDataSource(view: collectionView)
        let dataAdapter = ARCHEmptyListDataAdapter<D, VM>()
        self.init(dataSource: dataSource, dataAdapter: dataAdapter)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View

    public var collectionView: UICollectionView {
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
        collectionView.reloadData()
    }

//    public var data: [D] = [] {
//        didSet {
///*
//            if UIView.areAnimationsEnabled {
//                let changes = diff(old: dataAdapter.data, new: data)
//                reloadViewWith(data: data, changes: changes)
//            } else {
//                dataAdapter.data = data
//                collectionView.reloadData()
//            }
//*/
//        }
//    }

/*
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
    }*/
}
