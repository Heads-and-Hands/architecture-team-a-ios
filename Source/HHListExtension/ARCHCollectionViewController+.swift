//
//  ARCHCollectionViewController+.swift
//  HHList
//
//  Created by basalaev on 05.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

extension ARCHCollectionViewController: ARCHViewRenderable {

    public typealias ViewState = [D]

    // MARK: - ARCHViewInput

    public func set(visible: Bool) {
        collectionView.isHidden = !visible
        if !visible {
            data = []
        }
    }

    // MARK: - ARCHViewRenderable

    public func render(state: ViewState) {
        data = state
    }
}
