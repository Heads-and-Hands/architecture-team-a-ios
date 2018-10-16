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
import HHPreferences

enum ApiTarget {
    case main
}

extension ApiTarget: ARCHTargetType {

    var baseURL: URL {
        guard let url = URL(string: PreferencesManager.shared.preference(for: Preferences.networkBasePath.rawValue) ?? "") else {
            fatalError("Wrong debug api base url")
        }
        return url
    }

    var path: String {
        switch self {
        case .main:
            return "bridges"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any]? {
        return ["format": "json"]
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
