//
//  ARCHCollectionViewController+.swift
//  HHList
//
//  Created by basalaev on 05.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

/*
extension ARCHViewInput where Self: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Realizated in ARCHTableViewDataSource")
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Realizated in ARCHTableViewDataSource")
    }
}*/

extension ARCHCollectionViewController: ARCHViewRenderable {

    public typealias State = [D]

    // MARK: - ARCHViewInput

    public func set(visible: Bool) {
        collectionView.isHidden = !visible
        if !visible {
            data = []
        }
    }

    // MARK: - ARCHViewRenderable

    public func render(state: State) {
        data = state
    }
}
