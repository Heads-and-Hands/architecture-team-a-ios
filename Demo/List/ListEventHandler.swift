//
//  ListEventHandler.swift
//  architecture
//
//  Created by basalaev on 08.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class ListEventHandler: ARCHEventHandler<ListState>, ListModuleInput {

    weak var moduleOutput: ListModuleOutput?

    func pressAddButton() {
        var newData: [ListDataModel] = []
        for _ in 0..<20 {
            newData.append(ListDataModel(active: false))
        }

        state.list += newData
    }
}
