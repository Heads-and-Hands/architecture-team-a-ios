//
//  SectionChildState.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

struct SectionChildState: ARCHState, ARCHStateSectionDataSource {

    var id: UUID

    // MARK: - Initialization

    init() {
        self.id = UUID()
    }

    init(id: UUID) {
        self.id = id
    }

    var viewModel: ChildOneSectionViewModel = ChildOneSectionViewModel(cellViewModels: [])

    var sectionViewModel: ARCHSectionViewModel {
        return viewModel
    }
}
