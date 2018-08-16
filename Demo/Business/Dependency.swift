//
//  Dependency.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Moya
import HHNetwork

typealias ApiProvider = ARCHMoyaProvider<ApiTarget>

class Dependency {

    static let shared = Dependency()

    private init() {}

    var application: UIApplication {
        return UIApplication.shared
    }

    var apiProvider: ApiProvider {
        let provider = ApiProvider(
            plugins: [signMoyaPlugin, loggerMoyaPlugin, activityMoyaPlugin, authObserverPlugin]
        )
        userStorage.add(delegate: provider)
        return provider
    }

    lazy var userStorage: ARCHKeychainUserStorage<User, String> = {
        let storage = ARCHKeychainUserStorage<User, String>()
        if let delegate = application.delegate as? ARCHUserStorageDelegate {
            storage.add(delegate: delegate)
        }
        return storage
    }()

    // MARK: - Private

    private var loggerMoyaPlugin: PluginType {
        return ARCHLoggerMoyaPlugin(printBlock: { text in
            print("\(text)")
        })
    }

    private var authObserverPlugin: PluginType {
        let plugin = ARCHAuthObserverMoyaPlugin()
        plugin.delegate = application.delegate as? ARCHAuthObserverMoyaPluginDelegate
        return plugin
    }

    private var activityMoyaPlugin: PluginType {
        return NetworkActivityPlugin(networkActivityClosure: { activityChangeType, _ in
            switch activityChangeType {
            case .began:
                self.application.isNetworkActivityIndicatorVisible = true
            case .ended:
                self.application.isNetworkActivityIndicatorVisible = false
            }
        })
    }

    private var signMoyaPlugin: PluginType {
        let plugin = ARCHSignMoyaPlugin()
        plugin.delegate = application.delegate as? ARCHSignMoyaPluginDelegate
        return plugin
    }
}
