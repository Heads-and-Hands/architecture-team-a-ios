//
//  ARCHApiResponse.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public struct ARCHApiResponse<T: Codable>: Codable {
    public var code: Int?
    public var name: String?
    public var message: String?
    public var data: T?
}
