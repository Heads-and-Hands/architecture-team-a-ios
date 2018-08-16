//
//  ARCHCollectionViewPagingManager.swift
//  HHModuleDemo
//
//  Created by basalaev on 17.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHCollectionViewPagingManager: ARCHPagingManager, UICollectionViewDelegate {

    public weak var delegate: UICollectionViewDelegate?

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayCell(indexPath: indexPath)
        delegate?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }

    // MARK: - UICollectionViewDelegate Proxy

    override open func responds(to aSelector: Selector!) -> Bool {
        if super.responds(to: aSelector) {
            return true
        }

        return delegate?.responds(to: aSelector) ?? false
    }

    override open func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let delegate = delegate, delegate.responds(to: aSelector) {
            return delegate
        }

        return super.forwardingTarget(for: aSelector)
    }
}
