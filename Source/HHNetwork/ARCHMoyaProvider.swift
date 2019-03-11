//
//  ARCHMoyaProvider.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Moya
import enum Result.Result

open class ARCHMoyaProvider<T: ARCHTargetType>: MoyaProvider<T>, ARCHUserStorageDelegate {

    private struct MoyaRequest {
        let target: T
        let progress: Moya.ProgressBlock?
        let completion: Moya.Completion
    }

    private let debugLog: ((String) -> Void)? = {
        if let debugMode = ProcessInfo.processInfo.environment["HHNetworkDebugMode"], Int(debugMode) == 1 {
            return { print("[\(Thread.isMainThread ? "main": "back")]" + $0) }
        } else {
            return nil
        }
    }()

    private var requests: [MoyaRequest] = []

    public var errorStatusDataHandler: ((JSONDecoder, Data) throws -> ARCHNetworkErrorDecodable)?

    @discardableResult
    open func sendRequest<Model: Codable>(
        target: T,
        for model: Model.Type,
        additionalStatusCodes statusCodes: [Int] = [],
        progressBlock: Moya.ProgressBlock? = nil,
        completion: @escaping (Model) -> Void,
        failure: @escaping (ARCHNetworkError) -> Void
        ) -> Cancellable {

        let completion = { [weak self] (result: Result<Moya.Response, Moya.MoyaError>) in
            guard let `self` = self else {
                return
            }

            let dateDecodingStrategy = self.dateDecodingStrategy
            
            switch result {
            case let .success(response):
                do {
                    self.debugLog?("[ARCHMoyaProvider] will success send request")
                    let decoder = self.jsonDecoder(dateDecodingStrategy: dateDecodingStrategy)
                    let model = try self.filterSuccessfulStatusCodes(response: response, statusCodes: statusCodes)
                        .map(model, using: decoder)
                    completion(model)
                    self.debugLog?("[ARCHMoyaProvider] did success send request")
                } catch {
                    self.debugLog?("[ARCHMoyaProvider] error map object type")
                    failure(self.map(error: error, dateDecodingStrategy: dateDecodingStrategy))
                }
            case let .failure(error):
                self.debugLog?("[ARCHMoyaProvider] will failure send request \(error)")
                let providerError = self.map(error: error, dateDecodingStrategy: dateDecodingStrategy)
                if providerError.status != NSURLErrorCancelled {
                    failure(providerError)
                } else {
                    self.debugLog?("[ARCHMoyaProvider] cancel operation")
                }
            }
        }

        return send(request: MoyaRequest(target: target,
                                         progress: progressBlock,
                                         completion: completion))
    }

    open var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .iso8601
    }

    private func send(request: MoyaRequest) -> Cancellable {
        return self.request(request.target, progress: request.progress, completion: { [weak self] result in
            switch result {
            case let .success(response):
                if response.statusCode == 401, request.target.authorization {
                    self?.debugLog?("[ARCHMoyaProvider] 401 status code")
                    self?.add(request: request)
                    // TODO: ... проверить что есть плагин
                } else {
                    self?.debugLog?("[ARCHMoyaProvider] prepare completion response")
                    self?.remove(request: request)
                    request.completion(.success(response))
                }
            case let .failure(error):
                self?.remove(request: request)
                request.completion(.failure(error))
            }
        })
    }

    private func filterSuccessfulStatusCodes(response: Response, statusCodes: [Int]) throws -> Response {
        if (try? response.filterSuccessfulStatusCodes()) != nil || statusCodes.contains(response.statusCode) {
            return response
        }

        throw MoyaError.statusCode(response)
    }

    private func repeatRequests() {
        debugLog?("[ARCHMoyaProvider] repeat requests")
        objc_sync_enter(self)
        while !requests.isEmpty {
            let request = requests.removeFirst()
            _ = send(request: request)
        }
        objc_sync_exit(self)
    }

    private func remove(request: MoyaRequest) {
        objc_sync_enter(self)
        debugLog?("[ARCHMoyaProvider] remove request")
        let requestDescribing = String(describing: request)
        if let index = requests.index(where: { String(describing: $0) == requestDescribing }) {
            requests.remove(at: index)
        }
        objc_sync_exit(self)
    }

    private func add(request: MoyaRequest) {
        objc_sync_enter(self)
        debugLog?("[ARCHMoyaProvider] add request")
        requests.append(request)
        objc_sync_exit(self)
    }

    // MARK: - ARCHUserStorageDelegate

    open func didUpdateUser(from: ARCHUser?, to: ARCHUser?) {
        if let from = from, let to = to, from.primaryKey == to.primaryKey {
            debugLog?("[ARCHMoyaProvider] relogin user")
            // Если зашли под тем же пользователем
            repeatRequests()
        }
    }
}

private extension ARCHMoyaProvider {

    func jsonDecoder(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> JSONDecoder {
        let result = JSONDecoder()
        result.dateDecodingStrategy = dateDecodingStrategy
        return result
    }

    func map(error: Swift.Error, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> ARCHNetworkError {
        debugLog?("[ARCHMoyaProvider] map error \(error)")
        switch error {
        case let moyaError as MoyaError:
            return mapMoya(error: moyaError, dateDecodingStrategy: dateDecodingStrategy)
        default:
            debugLog?("[ARCHMoyaProvider] not moya error")
            return ARCHNetworkError(message: "Unrecognized error")
        }
    }

    func mapMoya(error: MoyaError, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> ARCHNetworkError {
        debugLog?("[ARCHMoyaProvider] will parse moya error")
        switch error {

        /// Indicates a response failed with an invalid HTTP status code.
        case let .statusCode(response):
            debugLog?("[ARCHMoyaProvider] will parse moya error .statusCode")
            do {
                let decoder = jsonDecoder(dateDecodingStrategy: dateDecodingStrategy)

                if let handler = errorStatusDataHandler {
                    return try handler(decoder, response.data).error
                }

                let serverError = try decoder.decode(ARCHServerError.self, from: response.data)
                return ARCHNetworkError(status: response.statusCode,
                                        code: serverError.code,
                                        name: serverError.name,
                                        message: serverError.message)
            } catch {
                debugLog?("[ARCHMoyaProvider] not decode error .statusCode")
                return ARCHNetworkError(status: response.statusCode, message: error.localizedDescription)
            }

        /// Indicates a response failed to map to a Decodable object.
        case let .objectMapping(error, response):
            debugLog?("[ARCHMoyaProvider] will parse moya error .objectMapping")
            guard let err = error as? DecodingError else {
                debugLog?("[ARCHMoyaProvider] not found DecodingError")
                return ARCHNetworkError(status: response.statusCode, message: error.localizedDescription)
            }
            return mapObjectMapping(error: err, response: response)

        /// Indicates a response failed to map to an image, JSON structure, String.
        case .imageMapping(let response), .jsonMapping(let response), .stringMapping(let response):
            debugLog?("[ARCHMoyaProvider] will parse moya error .imageMapping | .jsonMapping | .stringMapping")
            return ARCHNetworkError(status: response.statusCode, message: "Other mapping error")

        /// Indicates a response failed due to an underlying `Error`.
        case let .underlying(error, response):
            debugLog?("[ARCHMoyaProvider] will parse moya error .underlying")
            let err = error as NSError
            return ARCHNetworkError(status: response?.statusCode ?? err.code, message: error.localizedDescription)

        /// Indicates that an `Endpoint` failed to map to a `URLRequest`.
        case let .requestMapping(message):
            debugLog?("[ARCHMoyaProvider] will parse moya error .requestMapping")
            return ARCHNetworkError(message: message)

        /// Indicates that an `Endpoint` failed to encode the parameters for the `URLRequest`.
        case let .parameterEncoding(error):
            debugLog?("[ARCHMoyaProvider] will parse moya error .parameterEncoding")
            return ARCHNetworkError(message: error.localizedDescription)

        /// Indicates that Encodable couldn't be encoded into Data
        case let .encodableMapping(error):
            debugLog?("[ARCHMoyaProvider] will parse moya error .encodableMapping")
            return ARCHNetworkError(message: error.localizedDescription)
        }
    }

    func mapObjectMapping(error: DecodingError, response: Moya.Response) -> ARCHNetworkError {
        return ARCHNetworkError(status: response.statusCode, message: error.localizedDescription)
    }
}
