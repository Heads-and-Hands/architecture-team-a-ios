//
//  CellChildState.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

struct CellChildState: ARCHState, ARCHStateDataSource {

    var id: UUID

    // MARK: - Initialization

    init() {
        self.id = UUID()
    }

    init(id: UUID) {
        self.id = id
    }

    var viewModel: ChildOneTVCellViewModel = ChildOneTVCellViewModel(title: "", isOn: false, eventHandler: nil)

    var cellViewModel: ARCHCellViewModel {
        return viewModel
    }
}
