//
//  IndicationDemoEventHandler.swift
//  architecture
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class IndicationDemoEventHandler: ARCHEventHandler<IndicationDemoState>, IndicationDemoModuleInput {

    weak var moduleOutput: IndicationDemoModuleOutput?

    func startLoading() {
        state.indication = IndicationState(type: .loading, title: nil)
    }

    func finishLoadingWithSomeData() {
        var newData: [SimpleEntity] = []
        for id in 0..<20 {
            newData.append(SimpleEntity(id: id))
        }

        updateState {
            state.list = newData
            state.header = HeaderViewState()
        }
    }

    func finishLoadingWithEmptyData() {
        state.indication = IndicationState(type: .empty, title: "Тут пусто")
    }

    func finishLoadingWithError() {
        state.indication = IndicationState(type: .error, title: "Ошибка")
    }
}
