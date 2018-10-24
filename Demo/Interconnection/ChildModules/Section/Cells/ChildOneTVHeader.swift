//
//  ChildOneTVHeader.swift
//  HHInterconnectionDemo
//
//  Created by Eugene Sorokin on 24/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class ChildOneTVHeader: UITableViewHeaderFooterView, ARCHHeaderFooterView {

    var viewModel: ChildOneTVHeaderViewModel?

    private let label = UILabel()

    // MARK: - Initializaiton

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.text = "SECTION"
        label.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0)
        ])

        let separator = configureSeparator()

        contentView.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configureSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        return view
    }

    // MARK: - Render

    func render(viewModel: ChildOneTVHeaderViewModel) {
    }
}
