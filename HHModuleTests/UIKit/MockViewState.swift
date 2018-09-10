//
//  MockViewState.swift
//  HHModuleTests
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import HHModule

protocol MockViewState: Equatable, ARCHState {

    associatedtype T: Equatable

    var value: T { get set }

    init()

    mutating func chageRandomly()
}
