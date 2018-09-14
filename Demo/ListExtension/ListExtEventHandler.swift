//
//  ListExtEventHandler.swift
//  architecture
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class ListExtEventHandler: ARCHEventHandler<ListExtState>, ListExtModuleInput {

    weak var moduleOutput: ListExtModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    func pressAddButton() {
        var newData: [ListDataModel] = []
        for id in state.list.count..<state.list.count + 20 {
            newData.append(ListDataModel(id: id, active: false))
        }

        state.list += newData
    }
}
