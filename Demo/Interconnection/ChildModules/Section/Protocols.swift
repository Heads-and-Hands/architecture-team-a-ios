//
//  ARCHStateDataSource.swift
//  HHInterconnectionDemo
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

protocol ARCHStateDataSource {

    var sectionViewModel: ARCHSectionViewModel { get }
}

protocol ARCHChildModule {

    func configure(for dataSource: ARCHTableViewDataSource)
}
