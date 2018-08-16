//
//  ARCHPagingManagerIO.swift
//  HHModuleDemo
//
//  Created by basalaev on 18.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public typealias ARCHPagingManagerCompletion = (Int?, Int?) -> Void

public protocol ARCHPagingManagerOutput: class {

    /**
     @param offset - смещение
     @param pageSize - кол-во загружаемых элементов
     @param completion - клажура (Count loaded items: Int?, Total items: Int?), в случае ошибки передавать (nil, nil)
     */
    func performRequest(offset: Int, pageSize: Int, completion: @escaping ARCHPagingManagerCompletion) -> ARCHPagingManagerCancellable?
}

public protocol ARCHPagingManagerInput {
    func willDisplayCell(indexPath: IndexPath)
    func performLoadNextData()
    func performRefreshData()
}
