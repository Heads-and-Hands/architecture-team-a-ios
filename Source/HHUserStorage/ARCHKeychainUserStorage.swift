//
//  ARCHKeychainUserStorage.swift
//  architecture
//
//  Created by basalaev on 14.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation
import KeychainAccess

open class ARCHKeychainUserStorage<U: ARCHUser, T: ARCHToken>: ARCHUserStorage<U, T> {

    private let keychain = Keychain()

    private let debugLog: ((String) -> Void)? = {
        if let debugMode = ProcessInfo.processInfo.environment["ARCHKeychainUserStorageDebugMode"], Int(debugMode) == 1 {
            return { print($0) }
        } else {
            return nil
        }
    }()

    public override init() {
        super.init()
        debugLog?("[ARCHKeychainUserStorage] initialize")

        if isAuthorizate {
            user = read(key: .user)
            token = read(key: .token)
        }
    }

    open override func save(user: U?, token: T?) {
        debugLog?("[ARCHKeychainUserStorage] save values")

        write(value: user, key: .user)
        write(value: token, key: .token)
        isAuthorizate = user != nil && token != nil

        super.save(user: user, token: token)
    }

    // MARK: -

    private let isAuthorizateKey = "ARCHKeychainUserStorageIsAuthorizateKey"
    private var isAuthorizate: Bool {
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue, forKey: isAuthorizateKey)
            userDefaults.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: isAuthorizateKey)
        }
    }

    // MARK: - Private Read/Write

    private enum Keys: String {
        case user = "KeychainUserStorageUser"
        case token = "KeychainUserStorageToken"
    }

    private func write<T: Codable>(value: T?, key: Keys) {
        debugLog?("[ARCHKeychainUserStorage] write value for key \(key.rawValue)")

        if let value = value {
            if let data = try? JSONEncoder().encode(bridge(value: value)) {
                keychain[data: key.rawValue] = data
            } else {
                debugLog?("[ARCHKeychainUserStorage] fail encode value")
            }
        } else {
            debugLog?("[ARCHKeychainUserStorage] clear value")
            keychain[data: key.rawValue] = nil
        }
    }

    private func read<T: Codable>(key: Keys) -> T? {
        debugLog?("[ARCHKeychainUserStorage] read value for key \(key.rawValue)")

        guard let data = try? keychain.getData(key.rawValue), let valueData = data else {
            debugLog?("[ARCHKeychainUserStorage] not found value in keychain")
            return nil
        }

        guard let value = try? JSONDecoder().decode([T].self, from: valueData) else {
            debugLog?("[ARCHKeychainUserStorage] fail decode value")
            return nil
        }

        return extractBridged(value: value)
    }

    // MARK: - JSON bridge

    /**
     https://forums.swift.org/t/allowing-top-level-fragments-in-jsondecoder/11750

     JSONDecoder не может конвертировать объекты верхнего уровня String, Int, Bool
     Используется следующий костыль
     */
    private func bridge<T: Codable>(value: T) -> [T] {
        return [value]
    }

    private func extractBridged<T>(value: [T]) -> T? {
        return value.first
    }
}
