//
//  SkeletonListEventHandler.swift
//  architecture
//
//  Created by basalaev on 28.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class SkeletonListEventHandler: ARCHEventHandler<SkeletonListState>, SkeletonListModuleInput {

    weak var moduleOutput: SkeletonListModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()

        // TODO: Установить значение индикации
    }

    func pressAddButton() {
        var newData: [SimpleEntity] = []
        for id in state.list.count..<state.list.count + 20 {
            newData.append(SimpleEntity(id: id))
        }

        state.list += newData
    }
}
