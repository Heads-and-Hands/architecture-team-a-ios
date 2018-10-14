//
//  ARCHListView.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public protocol ARCHListView {
    associatedtype CellType
    associatedtype HeaderFooterType

    associatedtype DataSourceType: NSObjectProtocol

    func reloadDataSource()

    func set(dataSource: DataSourceType?)

    func register(cell: CellType.Type, cellID: String)
    func register(header: HeaderFooterType.Type, headerID: String)
    func register(footer: HeaderFooterType.Type, footerID: String)

    func reusableCellWith(id: String, indexPath: IndexPath) -> CellType?
    func reusableHeaderWith(id: String, indexPath: IndexPath) -> HeaderFooterType?
    func reusableFooterWith(id: String, indexPath: IndexPath) -> HeaderFooterType?
}
