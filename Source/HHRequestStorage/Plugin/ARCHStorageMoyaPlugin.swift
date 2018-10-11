//
//  Plugin.swift
//  HHRequestStorage
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import Moya
import enum Result.Result

final public class ARCHStorageMoyaPlugin: PluginType {

    private var storage: ARCHRequestStorageProtocol?

    // MARK: - Initialization

    public init() {
        self.storage = ARCHRequestStorage.shared
    }

    public init(storage: ARCHRequestStorageProtocol) {
        self.storage = storage
    }

    // MARK: - PluginType

    public func willSend(_ request: RequestType, target: TargetType) {
        guard let request = request.request else {
            return
        }

        storage?.log(request: request)
    }

    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        storage?.log(result: result)
    }
}
