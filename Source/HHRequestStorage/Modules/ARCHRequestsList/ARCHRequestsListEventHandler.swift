//
//  ARCHRequestsListEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestsListEventHandler: ARCHEventHandler<ARCHRequestsListState>,
ARCHRequestsListModuleInput, ARCHRequestsListModuleViewOutput {

    weak var moduleOutput: ARCHRequestsListModuleOutput?

    var storage: ARCHRequestStorageProtocol?

    private var context = ARCHRequestStorage.viewContext

    override func viewIsReady() {
        super.viewIsReady()

        let requests = storage?.requests ?? []

        state.list = requests.sorted(by: { ($0.createdAt ?? Date()) > ($1.createdAt ?? Date()) })
    }

    // MARK: - ARCHRequestsListModuleViewOutput

    func didSelectCell(with row: Int) {
        guard row < state.list.count else {
            return
        }

        ARCHRequestsInfoConfigurator { (moduleInput: ARCHRequestsInfoModuleInput) -> ARCHRequestsInfoModuleOutput? in
            var input = moduleInput
            input.requesModel = self.state.list[row]
            return nil
        }.router.transit(from: router, options: [ARCHRouterPushOptions()], animated: true)
    }
}
