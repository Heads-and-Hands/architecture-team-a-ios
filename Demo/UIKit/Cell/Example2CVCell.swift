//
//  Example2CVCell.swift
//  architecture
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class Example2CVCell: UICollectionViewCell, ARCHCell {
    typealias ViewModel = Example2CVCellViewModel

    var viewModel: ViewModel?

    @IBOutlet var titleLabel: UILabel!

    func render(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
    }
}
