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

    func preference(for key: String) -> String?

    func presentPreferences(for key: String, in viewController: UIViewController)

    func isSet(for key: String) -> Bool
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
        if let jsonData = try? JSONEncoder().encode(makeUnique(preferences: preferences)) {
            storage.set(jsonData, forKey: key)
        }
    }

    public func preference(for key: String) -> String? {
        guard let data = storage.data(forKey: key),
            let preferences = try? JSONDecoder().decode(Array<Preference>.self, from: data) else {
                return nil
        }

        return preferences.first(where: { $0.isSelected })?.value
    }

    public func isSet(for key: String) -> Bool {
        guard let data = storage.data(forKey: key),
            (try? JSONDecoder().decode(Array<Preference>.self, from: data)) != nil else {
                return false
        }
        return true
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

    // MARK: - Private

    private func makeUnique(preferences: [Preference]) -> [Preference] {

        var preferences = preferences

        for index in 0 ..< preferences.count where preferences[index].name.isEmpty {
            preferences[index].name = "Default"
        }

        let index = preferences.lastIndex(where: { $0.isSelected }) ?? 0

        for indexI in 0 ..< preferences.count {
            preferences[indexI].isSelected = false

            let item = preferences[indexI]
            var counter = 1

            for indexJ in (indexI + 1) ..< preferences.count where item.name == preferences[indexJ].name {
                counter += 1
                preferences[indexJ].name = "\(item.name)_\(counter)"
            }
        }

        if !preferences.isEmpty {
            preferences[index].isSelected = true
        }

        return preferences
    }
}
