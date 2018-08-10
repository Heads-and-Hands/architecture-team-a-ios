//
//  ARCHCellViewModel.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol ARCHCellViewModel {
}

// MARK: - Initialize

public protocol ARCHModelAbstractInitilizable {
    static func create(data: Any) -> Any?
}

public protocol ARCHModelInitilizable: ARCHModelAbstractInitilizable {
    associatedtype Data: Any
    init(data: Data)
}

public extension ARCHModelInitilizable where Data: Any {

    static func create(data: Any) -> Any? {
        guard let data = data as? Data else {
            return nil
        }

        return self.init(data: data)
    }
}
