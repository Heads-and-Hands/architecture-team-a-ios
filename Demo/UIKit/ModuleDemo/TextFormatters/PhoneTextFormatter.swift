//
//  PhoneTextFormatter.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHInputField

class PhoneTextFormatter: ARCHTextFormatterProtocol {

    private let mask: String = "+#(###)####-##-##"
    private let searchChar = Character("#")

    func format(text: String) -> String {

        var result = mask

        for char in digits(from: text) {
            guard let index = result.firstIndex(of: searchChar) else {
                break
            }

            result.remove(at: index)
            result.insert(char, at: index)
        }

        if let index = result.firstIndex(of: searchChar) {
            let range = index ..< result.endIndex
            result.removeSubrange(range)
        }

        result = result.trimmingCharacters(in: CharacterSet(charactersIn: "()-"))

        return result
    }

    // MARK: - Private

    private func digits(from text: String) -> String {
        let characterSet = NSCharacterSet.decimalDigits.inverted
        let stringArray = text.components(separatedBy: characterSet)
        return stringArray.joined()
    }
}
