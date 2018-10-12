//
//  ARCHRequestsListEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestsListEventHandler: ARCHEventHandler<ARCHRequestsListState>, ARCHRequestsListModuleInput {

    weak var moduleOutput: ARCHRequestsListModuleOutput?

    var storage: ARCHRequestStorageProtocol?

    private var context = ARCHRequestStorage.viewContext

    override func viewIsReady() {
        super.viewIsReady()

        let requests = storage?.requests ?? []

        state.list = requests.sorted(by: { ($0.createdAt ?? Date()) > ($1.createdAt ?? Date()) })
    }
}
