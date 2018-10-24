//
//  CellParentState.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

struct CellParentState: ARCHState {

    var childStates: [ARCHState] = []

    var viewModels: [ARCHCellViewModel] {
        return childStates.compactMap({ ($0 as? ARCHStateDataSource)?.cellViewModel })
    }
}
