//
//  SectionListEventHandler.swift
//  architecture
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

class SectionListSectionViewModel: ARCHSectionViewModel {
    let items: [SimpleEntity]

    init(items: [SimpleEntity]) {
        self.items = items
    }

    var headerViewModel: ARCHHeaderFooterViewModel? {
        return nil
    }

    var footerViewModel: ARCHHeaderFooterViewModel? {
        return nil
    }

    var numberOfItems: Int {
        return items.count
    }

    func cellViewModel(at index: Int) -> ARCHCellViewModel {
        return Example2CVCellViewModel(data: items[index])
    }
}

final class SectionListEventHandler: ARCHEventHandler<SectionListState>, SectionListModuleInput, ARCHSectionDataSourceAdapter {

    weak var moduleOutput: SectionListModuleOutput?

    private var sectionViewModels: [SectionListSectionViewModel] = []

    func pressAddButton() {

        var items: [SimpleEntity] = []
        for id in 0..<20 {
            items.append(SimpleEntity(id: id))
        }

        sectionViewModels.append(SectionListSectionViewModel(items: items))
        viewSetNeedsRedraw()
    }

    // MARK: - ARCHSectionDataSourceAdapter

    var sectionsCount: Int {
        return sectionViewModels.count
    }

    func sectionViewModelAt(index: Int) -> ARCHSectionViewModel {
        return sectionViewModels[index]
    }
}
