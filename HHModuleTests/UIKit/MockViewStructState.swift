//
//  MockViewStructState.swift
//  HHModuleTests
//
//  Created by basalaev on 07.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import HHModule

struct MockViewStructState: MockStateProtocol {

    typealias T = String

    var value: String

    init() {
        self.value = randomStringNotEqula(nil)
    }

    mutating func chageRandomly(constraint: String?) {
        let constraint = constraint ?? value
        value = randomStringNotEqula(constraint)
    }
}
