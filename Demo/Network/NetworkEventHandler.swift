//
//  NetworkEventHandler.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHNetwork

final class NetworkEventHandler: ARCHEventHandler<NetworkState>, NetworkModuleInput {

    weak var moduleOutput: NetworkModuleOutput?
    var apiProvider: ApiProvider?

    override func viewIsReady() {
        super.viewIsReady()

        apiProvider?.sendRequest(
            target: .main,
            for: MainResponse.self,
            completion: { result in
                print("\(result)")
            },
            failure: { error in
                print("\(error)")
            }
        )
    }
}
