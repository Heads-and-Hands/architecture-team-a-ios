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

        apiProvider?.requestTarget(.main, for: ARCHApiResponse<MainResponse>.self, completion: { result in
            switch result {
            case let .success(response):
                print("\(response)")
            case let .failure(error):
                print("\(error)")
            }
        })
    }
}
