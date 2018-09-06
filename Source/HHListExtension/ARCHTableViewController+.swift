//
//  ARCHTableViewController.swift
//  ListExtension
//
//  Created by basalaev on 15.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
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
}
*/
extension ARCHTableViewController: ARCHViewRenderable {

    public typealias State = [D]

    // MARK: - ARCHViewInput

    public func set(visible: Bool) {
        tableView.isHidden = !visible
        if !visible {
            data = []
        }
    }

    // MARK: - ARCHViewRenderable

    public func render(state: State) {
        data = state
    }
}
