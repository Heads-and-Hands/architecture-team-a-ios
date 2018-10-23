//
//  ARCHListDataSourceAdapter.swift
//  HHModuleDemo
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol ARCHListDataSourceAdapter: class {
    var sectionsCount: Int { get }

    func numberOfRowsIn(section: Int) -> Int
    func cellViewModelAt(indexPath: IndexPath) -> ARCHCellViewModel
    func headerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel?
    func footerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel?
}

public extension ARCHListDataSourceAdapter {

    var sectionsCount: Int {
        return 1
    }

    func headerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel? {
        return nil
    }

    func footerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel? {
        return nil
    }
}
