//
//  CellParentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class CellParentEventHandler: ARCHEventHandler<CellParentState>, CellParentModuleInput, ARCHListDataSourceAdapter {

    weak var moduleOutput: CellParentModuleOutput?

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

    // MARK: - ARCHListDataSourceAdapter

    func numberOfRowsIn(section: Int) -> Int {
        return state.viewModels.count
    }

    func cellViewModelAt(indexPath: IndexPath) -> ARCHCellViewModel {
        return state.viewModels[indexPath.row]
    }
}
