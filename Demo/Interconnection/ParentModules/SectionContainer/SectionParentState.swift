//
//  SectionParentState.swift
//  architecture
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

struct SectionParentState: ARCHState {

    var childStates: [ARCHState] = []

    var sectionViewModels: [ARCHSectionViewModel] {
        return childStates.compactMap({ ($0 as? ARCHStateSectionDataSource)?.sectionViewModel })
    }
}
