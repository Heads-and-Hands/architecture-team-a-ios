//
//  ARCHTableViewController.swift
//  ListExtension
//
//  Created by basalaev on 15.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHList

extension ARCHTableViewController: ARCHViewRenderable {

    public typealias ViewState = [D]

    // MARK: - ARCHViewInput

    public func set(visible: Bool) {
        tableView.isHidden = !visible
        if !visible {
            data = []
        }
    }

    // MARK: - ARCHViewRenderable

    public func render(state: ViewState) {
        data = state
    }
}
