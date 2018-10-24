//
//  ChildSectionViewModel.swift
//  HHInterconnectionDemo
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class ChildOneSectionViewModel: ARCHSectionViewModel {

    var cellViewModels: [ChildOneTVCellViewModel] = []

    init(cellViewModels: [ChildOneTVCellViewModel]) {
        self.cellViewModels = cellViewModels
    }

    // MARK: - ARCHSectionViewModel

    var headerViewModel: ARCHHeaderFooterViewModel? {
        return ChildOneTVHeaderViewModel()
    }

    var footerViewModel: ARCHHeaderFooterViewModel? {
        return nil
    }

    var numberOfItems: Int {
        return cellViewModels.count
    }

    func cellViewModel(at index: Int) -> ARCHCellViewModel {
        return cellViewModels[index]
    }
}
