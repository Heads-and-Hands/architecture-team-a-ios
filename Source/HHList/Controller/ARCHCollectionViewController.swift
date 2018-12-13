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
        collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
        mapBlock: ((D) -> VM?)? = nil
        ) {

        let dataSource = ARCHCollectionViewDataSource(view: collectionView)
        let dataAdapter = ARCHEmptyListDataAdapter<D, VM>(map: mapBlock)
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

    public func viewModelAt(indexPath: IndexPath) -> VM? {
        return dataAdapter.cellViewModelAt(indexPath: indexPath) as? VM
    }
}
