//
//  ARCHTableViewPagingManager.swift
//  HHModuleDemo
//
//  Created by basalaev on 17.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHTableViewPagingManager: ARCHPagingManager, UITableViewDelegate {

    public weak var delegate: UITableViewDelegate?

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        willDisplayCell(indexPath: indexPath)
        delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }

    // MARK: - UITableViewDelegate Proxy

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
