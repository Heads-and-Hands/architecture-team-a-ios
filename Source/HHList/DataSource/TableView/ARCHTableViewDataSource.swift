//
//  ARCHTableViewDataSource.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHTableViewDataSource: ARCHListDataSource<UITableView>, UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsIn(section: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return reusableCell(indexPath: indexPath)
    }

    // TODO: TAbleView Delegate

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return reusableHeader(indexPath: IndexPath(row: 0, section: section))
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return reusableFooter(indexPath: IndexPath(row: 0, section: section))
    }
}

extension UITableView: ARCHListView {
    public typealias CellType = UITableViewCell
    public typealias HeaderFooterType = UITableViewHeaderFooterView
    public typealias DataSourceType = UITableViewDataSource

    public func reloadDataSource() {
        reloadData()
    }

    public func set(dataSource: DataSourceType?) {
        self.dataSource = dataSource
    }

    public func register(cell: CellType.Type, cellID: String) {
        let bundle = Bundle(for: cell)
        let nibName = String(describing: cell)

        if bundle.path(forResource: nibName, ofType: "nib") == nil {
            register(cell, forCellReuseIdentifier: cellID)
        } else {
            let nib = UINib(nibName: nibName, bundle: bundle)
            register(nib, forCellReuseIdentifier: cellID)
        }
    }

    public func register(header: HeaderFooterType.Type, headerID: String) {
        register(reusableView: header, viewID: headerID)
    }

    public func register(footer: HeaderFooterType.Type, footerID: String) {
        register(reusableView: footer, viewID: footerID)
    }

    public func reusableCellWith(id: String, indexPath: IndexPath) -> CellType? {
        return dequeueReusableCell(withIdentifier: id)
    }

    public func reusableHeaderWith(id: String, indexPath: IndexPath) -> HeaderFooterType? {
        return dequeueReusableHeaderFooterView(withIdentifier: id)
    }

    public func reusableFooterWith(id: String, indexPath: IndexPath) -> HeaderFooterType? {
        return dequeueReusableHeaderFooterView(withIdentifier: id)
    }

    // MARK: - Private

    func register(reusableView: HeaderFooterType.Type, viewID: String) {
        let bundle = Bundle(for: reusableView)
        let nibName = String(describing: reusableView)

        if bundle.path(forResource: nibName, ofType: "nib") == nil {
            register(reusableView, forHeaderFooterViewReuseIdentifier: viewID)
        } else {
            let nib = UINib(nibName: nibName, bundle: bundle)
            register(nib, forHeaderFooterViewReuseIdentifier: viewID)
        }
    }
}
