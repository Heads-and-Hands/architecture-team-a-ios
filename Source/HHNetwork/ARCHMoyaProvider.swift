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

    private var requests: [MoyaRequest] = []

    @discardableResult
    open func requestTarget<Model: Codable>(
        _ target: T,
        for model: Model.Type,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601,
        progressBlock: Moya.ProgressBlock? = nil,
        completion: @escaping (Result<Model, ARCHNetworkError>) -> Void
        ) -> Cancellable {

        let completion = { [weak self] (result: Result<Moya.Response, Moya.MoyaError>) in
            guard let `self` = self else {
                return
            }

            switch result {
            case let .success(response):
                do {
                    let decoder = self.jsonDecoder(dateDecodingStrategy: dateDecodingStrategy)
                    let model = try response.filterSuccessfulStatusCodes().map(model, using: decoder)
                    completion(.success(model))
                } catch {
                    let networkError = self.map(error: error, dateDecodingStrategy: dateDecodingStrategy)
                    completion(.failure(networkError))
                }
            case let .failure(error):
                let providerError = self.map(error: error, dateDecodingStrategy: dateDecodingStrategy)
                if providerError.status != NSURLErrorCancelled {
                    completion(.failure(providerError))
                }
            }
        }

        let request = MoyaRequest(target: target,
                                  progress: progressBlock,
                                  completion: completion)
        return send(request: request)
    }

    private func send(request: MoyaRequest) -> Cancellable {
        return self.request(request.target, progress: request.progress, completion: { [weak self] result in
            switch result {
            case let .success(response):
                if response.statusCode == 401, request.target.authorization {
                    self?.add(request: request)
                    // TODO: ... проверить что есть плагин
                } else {
                    self?.remove(request: request)
                    request.completion(.success(response))
                }
            case let .failure(error):
                self?.remove(request: request)
                request.completion(.failure(error))
            }
        })
    }

    private func repeatRequests() {
        while !requests.isEmpty {
            objc_sync_enter(self)
            let request = requests.removeFirst()
            _ = send(request: request)
            objc_sync_exit(self)
        }
    }

    private func remove(request: MoyaRequest) {
        objc_sync_enter(self)
        let requestDescribing = String(describing: request)
        if let index = requests.index(where: { String(describing: $0) == requestDescribing }) {
            requests.remove(at: index)
        }
        objc_sync_exit(self)
    }

    private func add(request: MoyaRequest) {
        objc_sync_enter(self)
        requests.append(request)
        objc_sync_exit(self)
    }

    // MARK: - ARCHUserStorageDelegate

    open func didUpdateUser(from: ARCHUser?, to: ARCHUser?) {
        if let from = from, let to = to, from.primaryKey == to.primaryKey {
            // Если зашли под тем же пользователем
            repeatRequests()
        }
    }
}

private extension MoyaProvider {

    func jsonDecoder(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> JSONDecoder {
        let result = JSONDecoder()
        result.dateDecodingStrategy = dateDecodingStrategy
        return result
    }

    func map(error: Swift.Error, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> ARCHNetworkError {
        switch error {
        case let moyaError as MoyaError:
            return mapMoya(error: moyaError, dateDecodingStrategy: dateDecodingStrategy)
        default:
            return ARCHNetworkError(message: "Unrecognized error")
        }
    }

    func mapMoya(error: MoyaError, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> ARCHNetworkError {
        switch error {

        /// Indicates a response failed with an invalid HTTP status code.
        case let .statusCode(response):
            do {
                let decoder = jsonDecoder(dateDecodingStrategy: dateDecodingStrategy)
                return try decoder.decode(ARCHNetworkError.self, from: response.data)
            } catch {
                return ARCHNetworkError(status: response.statusCode, message: error.localizedDescription)
            }

        /// Indicates a response failed to map to a Decodable object.
        case let .objectMapping(error, response):
            guard let err = error as? DecodingError else {
                return ARCHNetworkError(status: response.statusCode, message: error.localizedDescription)
            }
            return mapObjectMapping(error: err, response: response)

        /// Indicates a response failed to map to an image, JSON structure, String.
        case .imageMapping(let response), .jsonMapping(let response), .stringMapping(let response):
            return ARCHNetworkError(status: response.statusCode, message: "Other mapping error")

        /// Indicates a response failed due to an underlying `Error`.
        case let .underlying(error, response):
            let err = error as NSError
            return ARCHNetworkError(status: response?.statusCode ?? err.code, message: error.localizedDescription)

        /// Indicates that an `Endpoint` failed to map to a `URLRequest`.
        case let .requestMapping(message):
            return ARCHNetworkError(message: message)

        /// Indicates that an `Endpoint` failed to encode the parameters for the `URLRequest`.
        case let .parameterEncoding(error):
            return ARCHNetworkError(message: error.localizedDescription)

        /// Indicates that Encodable couldn't be encoded into Data
        case let .encodableMapping(error):
            return ARCHNetworkError(message: error.localizedDescription)
        }
    }

    func mapObjectMapping(error: DecodingError, response: Moya.Response) -> ARCHNetworkError {
        return ARCHNetworkError(status: response.statusCode, message: error.localizedDescription)
    }
}
