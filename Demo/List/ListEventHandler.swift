//
//  ListEventHandler.swift
//  architecture
//
//  Created by basalaev on 08.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

final class ListEventHandler: ARCHEventHandler<ListState>, ListModuleInput {

    weak var moduleOutput: ListModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    func pressAddButton() {
        var newData: [SimpleEntity] = []
        for id in state.list.count..<state.list.count + 20 {
            newData.append(SimpleEntity(id: "\(id)"))
        }

        state.list += newData
    }
}
