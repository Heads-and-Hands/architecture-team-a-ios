//
//  SkeletonDataSource.swift
//  HHModuleDemo
//
//  Created by basalaev on 27.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import UIKit

protocol ARCHSkeletonable {
}

class ARCHTableViewSkeleton<Cell: UITableViewCell & ARCHSkeletonable>: NSObject, UITableViewDataSource, ARCHIndicationView {

    weak var dataSource: UITableViewDataSource?

    private let cellId = "ARCHTableViewSkeletonCellId"
    private let count: Int
    private let view: UITableView
    private var enabled: Bool = false

    init(view: UITableView, count: Int = 0) {
        self.view = view
        self.count = count

        view.register(Cell.self, forCellReuseIdentifier: cellId)
    }

    // MARK: - ARCHIndicationView

    func update(state: Any) {
    }

    func showIn(container: UIView, layoutGuide: UILayoutGuide, animated: Bool) {
        enabled = true
    }

    func removeFrom(container: UIView) {
        enabled = false
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if enabled {
            return count
        } else {
            return dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if enabled {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
                fatalError("Not registrated cell")
            }

//            if let cell = cell as? Cell.Type {
//                // TODO: ...
//            }

            return cell
        } else if let dataSource = dataSource {
            return dataSource.tableView(tableView, cellForRowAt: indexPath)
        } else {
            fatalError("Bad env")
        }
    }

    // TODO: Добавить форфардинг сообщений
}
