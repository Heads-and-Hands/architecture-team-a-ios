//
//  Function.swift
//  HHModuleTests
//
//  Created by basalaev on 07.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

func randomIntNotEqual(_ value: Int?) -> Int {
    var result: Int

    repeat {
        result = Int(arc4random_uniform(1_000))
    } while result == (value ?? 0)

    return result
}

func randomStringNotEqula(_ value: String?) -> String {
    var result: String

    repeat {
        result = NSUUID().uuidString
    } while result == (value ?? "")

    return result
}
