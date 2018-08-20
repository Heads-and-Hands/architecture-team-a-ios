//
//  SimpleEntity.swift
//  HHListDemo
//
//  Created by basalaev on 16.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

struct SimpleEntity: Codable, Hashable {
    let id: Int

    var hashValue: Int {
        return id.hashValue
    }
}
