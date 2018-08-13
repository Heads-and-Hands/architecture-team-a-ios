//
// Created by Xander on 02.04.2018.
// Copyright (c) 2018 Heads and Hands. All rights reserved.
//

import Foundation
import Moya
import enum Result.Result

public final class ARCHLoggerMoyaPlugin: PluginType {

    private let printBlock: (String) -> Void

    public init(printBlock: @escaping (String) -> Void) {
        self.printBlock = printBlock
    }

    public func willSend(_ request: RequestType, target: TargetType) {
        log(request: request.request, target: target)
    }

    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        log(result: result, target: target)
    }
}

private extension ARCHLoggerMoyaPlugin {

    func log(request: URLRequest?, target: TargetType) {
        var startInfo = ["Start"]
        if let httpMethod = request?.httpMethod {
            startInfo.append(httpMethod)
        }
        startInfo.append("request:")
        startInfo.append(target.path)
        if let description = request?.description {
            startInfo.append(description)
        }

        printBlock(startInfo.joined(separator: " "))

        // Verbose: headers

        if let headers = request?.allHTTPHeaderFields {
            printBlock("Request headers: \(headers.description)")
        }

        // Verbose: body stream

        if let bodyStream = request?.httpBodyStream {
            printBlock("Request body stream: \(bodyStream.description)")
        }

        // Verbose: body

        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            printBlock("Request body: [\(stringOutput)]")
        }
    }

    func log(result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            var startInfo = ["Complete"]
            startInfo.append("\(response.statusCode)")
            if let httpMethod = response.request?.httpMethod {
                startInfo.append(httpMethod)
            }
            startInfo.append("request:")
            startInfo.append(target.path)
            if let description = response.request?.description {
                startInfo.append(description)
            }

            printBlock(startInfo.joined(separator: " "))

            // Verbose: headers
            // Json data

            printBlock("=========== BEGIN RESPONSE ===========")
            if let response = response.response {
                printBlock("Response headers: \(response.allHeaderFields)")
            }
            if let string = String(data: response.data, encoding: .utf8) {
                printBlock("Response json data: \(string)")
            }
            printBlock("============ END RESPONSE ============")
        case let .failure(error):
            printBlock("Response error: \(error)")
        }
    }
}
