//
//  ApiTarget.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Alamofire
import Moya
import HHNetwork

enum ApiTarget {
    case main
}

extension ApiTarget: ARCHTargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://api.xxx.Heads and Hands.ru/v1/") else {
            fatalError("Wrong debug api base url")
        }
        return url
    }

    var path: String {
        switch self {
        case .main:
            return "main"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any]? {
        return nil
    }

    var sampleData: Data {
        fatalError("sampleData has not been implemented")
    }

    var task: Task {
        switch self {
        default:
            guard let requestParameters = parameters else {
                return .requestPlain
            }
            return .requestParameters(
                parameters: requestParameters,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default
            )
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var authorization: Bool {
        return true
    }
}
