//
//  ARCHAuthObserverMoyaPlugin.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Moya
import enum Result.Result

public protocol ARCHAuthObserverMoyaPluginDelegate: class {
    func didExpiredAuthToken()
}

public class ARCHAuthObserverMoyaPlugin: PluginType {

    public weak var delegate: ARCHAuthObserverMoyaPluginDelegate?

    public init() {}

    public func didReceive(_ result: Result<Moya.Response, Moya.MoyaError>, target: TargetType) {
        guard let target = target as? ARCHTargetType, target.authorization else {
            return
        }

        if case let .success(response) = result, response.statusCode == 401 {
            delegate?.didExpiredAuthToken()
        }
    }
}
