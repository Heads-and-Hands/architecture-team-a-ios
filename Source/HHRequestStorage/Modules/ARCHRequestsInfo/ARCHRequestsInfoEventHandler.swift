//
//  ARCHRequestsInfoEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 12/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestsInfoEventHandler: ARCHEventHandler<ARCHRequestsInfoState>, ARCHRequestsInfoModuleInput {

    weak var moduleOutput: ARCHRequestsInfoModuleOutput?

    var requesModel: ARCHStorageRequest?

    override func viewIsReady() {
        super.viewIsReady()

        state.requestModel = requesModel
    }
}
