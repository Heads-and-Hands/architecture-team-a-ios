//
//  ARCHSkeletonCollectionViewController.swift
//  HHSkeletonDemo
//
//  Created by basalaev on 18.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

// swiftlint:disable:next line_length
public class ARCHSkeletonCollectionViewController<C: UICollectionViewCell & ARCHSkeletonView>: NSObject, UICollectionViewDataSource, ARCHSkeletonView {

    public let collectionView: UICollectionView
    private let cellID = "Skeleton Cell ID"

    public var delegate: UICollectionViewDelegate? {
        set {
            collectionView.delegate = newValue
        }
        get {
            return collectionView.delegate
        }
    }

    public var dataSource: UICollectionViewDataSource?

    public init(collectionView: UICollectionView = UICollectionView()) {
        self.collectionView = collectionView
        super.init()
        collectionView.register(C.self, forCellWithReuseIdentifier: cellID)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UICollectionViewDataSource

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    }

    // MARK: - ARCHSkeletonView

    public var skeletonSubviews: [UIView]? {
        return collectionView.visibleCells
    }

    public func set(isEnableSkeleton: Bool) {
        collectionView.dataSource = isEnableSkeleton ? self : dataSource
        collectionView.reloadData()

        if isEnableSkeleton {
            collectionView.visibleCells.forEach { cell in
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
