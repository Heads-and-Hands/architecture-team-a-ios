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

    func presentPreferences(for key: String, in viewController: UIViewController)
}

public enum PreferenceType: Int, Codable {
    case constant, custom
}

public struct Preference: Codable {

    var type: PreferenceType
    var name: String
    var value: String
    var isSelected: Bool

    public init(name: String, value: String, type: PreferenceType, isSelected: Bool) {
        self.type = type
        self.name = name
        self.value = value
        self.isSelected = isSelected
    }
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

    public func presentPreferences(for key: String, in viewController: UIViewController) {
        guard let data = storage.data(forKey: key),
            let preferences = try? JSONDecoder().decode(Array<Preference>.self, from: data) else {
                return
        }

        guard let vc = PreferencesConfigurator(moduleIO: { (moduleInput: PreferencesModuleInput) -> PreferencesModuleOutput? in
            var input = moduleInput
            input.preferences = preferences
            input.preferencesKey = key
            return nil
        }).router as? UIViewController else {
            return
        }

        viewController.present(vc, animated: true, completion: nil)
    }
}
