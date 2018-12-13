//
//  ARCHSectionDataSourceAdapter.swift
//  HHList
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol ARCHSectionDataSourceAdapter: ARCHListDataSourceAdapter {
    var sectionsCount: Int { get }

    func sectionViewModelAt(index: Int) -> ARCHSectionViewModel?
}

public extension ARCHSectionDataSourceAdapter {

    func numberOfRowsIn(section: Int) -> Int {
        let sectionViewModel = sectionViewModelAt(index: section)
        return sectionViewModel?.numberOfItems ?? 0
    }

    func cellViewModelAt(indexPath: IndexPath) -> ARCHCellViewModel {
        guard let sectionViewModel = sectionViewModelAt(index: indexPath.section) else {
            fatalError("Not found sectionVM indexPath \(indexPath)")
        }

        return sectionViewModel.cellViewModel(at: indexPath.item)
    }

    func headerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel? {
        let sectionViewModel = sectionViewModelAt(index: indexPath.section)
        return sectionViewModel?.headerViewModel
    }

    func footerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel? {
        let sectionViewModel = sectionViewModelAt(index: indexPath.section)
        return sectionViewModel?.footerViewModel
    }
}
