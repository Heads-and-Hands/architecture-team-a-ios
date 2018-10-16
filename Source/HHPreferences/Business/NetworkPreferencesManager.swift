//
//  File.swift
//  HHPreferences
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public protocol PreferencesProtocol: class {

    func setPreferences(key: String, preferences: [Preference])

    func getPreference(for key: String) -> String?

    func showPreferences(for key: String, in viewController: UIViewController)
}

public enum PreferenceType: Int, Codable {
    case constant, custom
}

public struct Preference: Codable {

    var type: PreferenceType
    var name: String
    var value: String
    var isSelected: Bool
}

open class PreferencesManager: PreferencesProtocol {

    private let storage = UserDefaults.standard

    // MARK: - Singleton

    public static var shared: PreferencesProtocol = PreferencesManager()

    private init() {}

    // MARK: - PreferencesProtocol

    public func setPreferences(key: String, preferences: [Preference]) {
        if let jsonData = try? JSONEncoder().encode(preferences) {
            storage.set(jsonData, forKey: key)
        }
    }

    public func getPreference(for key: String) -> String? {
        guard let data = storage.data(forKey: key),
            let preferences = try? JSONDecoder().decode(Array<Preference>.self, from: data) else {
                return nil
        }

        return preferences.first(where: { $0.isSelected })?.value
    }

    public func showPreferences(for key: String, in viewController: UIViewController) {
        guard let data = storage.data(forKey: key),
            let preferences = try? JSONDecoder().decode(Array<Preference>.self, from: data) else {
                return
        }
    }
}
