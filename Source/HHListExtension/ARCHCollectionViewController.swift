//
//  ARCHCollectionViewController.swift
//  ListExtension
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList
import DeepDiff

// swiftlint:disable:next line_length
public class ARCHCollectionViewController<D: Hashable, VM: ARCHCellViewModel & ARCHModelInitilizable, C: UICollectionViewCell & ARCHCell>: UIViewController {

    private let viewDataSource: ARCHCollectionViewDataSource
    private let dataAdapter: ARCHEmptyListDataAdapter<D, VM>

    public var delegate: ARCHListDataSourceDelegate? {
        set {
            viewDataSource.delegate = delegate
        }
        get {
            return viewDataSource.delegate
        }
    }

    public var dataSource: UICollectionViewDataSource? {
        set {
            viewDataSource.dataSource = dataSource
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

        super.init(nibName: nil, bundle: nil)
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

    override public func loadView() {
        view = collectionView
    }

    // MARK: - Data

    public var data: [D] = [] {
        didSet {
            let changes = diff(old: dataAdapter.data, new: data)
            reloadViewWith(data: data, changes: changes)
        }
    }

    private func reloadViewWith(data: [D], changes: [Change<D>]) {
        dataAdapter.data = data
        collectionView.reload(changes: changes,
                              section: 0,
                              completion: { _ in })
    }
}
