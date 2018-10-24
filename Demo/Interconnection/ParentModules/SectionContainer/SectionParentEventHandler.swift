//
//  SectionParentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class SectionParentEventHandler: ARCHEventHandler<SectionParentState>, SectionParentModuleInput, ARCHSectionDataSourceAdapter {

    weak var moduleOutput: SectionParentModuleOutput?

    private var childModules: [ARCHModuleInput] = []

    override func viewIsReady() {
        super.viewIsReady()
    }

    override func registerChildModule(_ module: ARCHModuleInput, for reuseIdentifire: String) {
        super.registerChildModule(module, for: reuseIdentifire)
        childModules.append(module)
    }

    override func didChange(childState: ARCHState) {
        super.didChange(childState: childState)
        viewSetNeedsRedraw()
    }

    // MARK: - ARCHSectionDataSourceAdapter

    var sectionsCount: Int {
        return state.sectionViewModels.count
    }

    func sectionViewModelAt(index: Int) -> ARCHSectionViewModel {
        return state.sectionViewModels[index]
    }
}
