//
//  ARCHRequestStorageModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol ARCHRequestsListModuleInput {
}

protocol ARCHRequestsListModuleOutput: class {
}

protocol ARCHRequestsListModuleViewOutput: ACRHViewOutput {

    func didSelectCell(with row: Int)
}
