//
// Created by Xander on 27.07.2018.
// Copyright (c) 2018 Heads and Hands. All rights reserved.
//

import Foundation
import Moya
import enum Result.Result

public protocol ARCHSignMoyaPluginDelegate: class {
    var signHeaderFields: [String: String] { get }
}

public class ARCHSignMoyaPlugin: PluginType {

    public weak var delegate: ARCHSignMoyaPluginDelegate?

    public init() {}

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? ARCHTargetType, target.authorization else {
            return request
        }

        let signHeaderFields = delegate?.signHeaderFields ?? [:]
        var headerFields = request.allHTTPHeaderFields ?? [:]

        for (key, value) in signHeaderFields {
            headerFields[key] = value
        }

        var newRequest = request
        newRequest.allHTTPHeaderFields = headerFields
        return newRequest
    }
}
