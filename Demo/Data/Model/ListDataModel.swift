//
//  ListDataModel.swift
//  HHModuleDemo
//
//  Created by HeadsAndHands on 14.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

class ListDataModel: Hashable {
    
    let id: Int
    var active: Bool
    
    var hashValue: Int {
        return id.hashValue
    }

    init(id: Int, active: Bool) {
        self.id = id
        self.active = active
    }
    
    static func == (lhs: ListDataModel, rhs: ListDataModel) -> Bool {
        return lhs.id == rhs.id
    }
}
