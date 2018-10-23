//
//  ARCHSectionDataSourceAdapter.swift
//  HHList
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

// TODO: Добавить информацию о ячейках для регистрации во вью

public protocol ARCHSectionDataSourceAdapter: ARCHListDataSourceAdapter {
    var sectionsCount: Int { get }

    func sectionViewModelAt(index: Int) -> ARCHSectionViewModel
}

public extension ARCHSectionDataSourceAdapter {

    func numberOfRowsIn(section: Int) -> Int {
        let sectionViewModel = sectionViewModelAt(index: section)
        return sectionViewModel.numberOfItems
    }

    func cellViewModelAt(indexPath: IndexPath) -> ARCHCellViewModel {
        let sectionViewModel = sectionViewModelAt(index: indexPath.section)
        return sectionViewModel.cellViewModel(at: indexPath.item)
    }

    func headerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel? {
        let sectionViewModel = sectionViewModelAt(index: indexPath.section)
        return sectionViewModel.headerViewModel
    }

    func footerViewModelAt(indexPath: IndexPath) -> ARCHHeaderFooterViewModel? {
        let sectionViewModel = sectionViewModelAt(index: indexPath.section)
        return sectionViewModel.footerViewModel
    }
}
