//
//  TableViewCells.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class ARCHStorageTVCell: UITableViewCell, ARCHCell {

    private let requestView = ARCHStorageCellView(title: "Request")
    private let responseView = ARCHStorageCellView(title: "Response")

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        let container = UIStackView(arrangedSubviews: [requestView, responseView])
        container.axis = .vertical
        container.spacing = 8.0
        container.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(container)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ARCHCell

    var viewModel: ARCHStorageTVCellViewModel?

    func render(viewModel: ARCHStorageTVCellViewModel) {
        requestView.update(date: viewModel.requestDate, values: viewModel.requestParameters)
        responseView.update(date: viewModel.responseDate, values: viewModel.responseParameters)
    }
}
