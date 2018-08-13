//
//  ARCHKeychainUserStorage.swift
//  architecture
//
//  Created by basalaev on 14.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import KeychainAccess

public class ARCHKeychainUserStorage<U: ARCHUser, T: ARCHToken>: ARCHUserStorage<U, T> {

    private let keychain = Keychain()

    public override init() {
        super.init()
        user = read(key: .user)
        token = read(key: .token)
    }

    public override func save(user: U, token: T) {
        write(value: user, key: .user)
        write(value: token, key: .token)

        super.save(user: user, token: token)
    }

    // MARK: - Private

    private enum Keys: String {
        case user = "KeychainUserStorageUser"
        case token = "KeychainUserStorageToken"
    }

    private func write<T: Codable>(value: T, key: Keys) {
        if let data = try? JSONEncoder().encode(value) {
            keychain[data: key.rawValue] = data
        }
    }

    private func read<T: Codable>(key: Keys) -> T? {
        guard let data = try? keychain.getData(key.rawValue), let valueData = data else {
            return nil
        }

        guard let value = try? JSONDecoder().decode(T.self, from: valueData) else {
            return nil
        }

        return value
    }
}
