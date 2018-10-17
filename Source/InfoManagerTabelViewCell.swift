//
//  InfoManagerTableViewCell.swift
//  InfoManager
//
//  Created by Eugene Sorokin on 17/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

class InfoManagerTableViewCell: UITableViewCell {

    // MARK: - UIKit

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let container = UIView()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        titleLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        titleLabel.textColor = .black

        valueLabel.font = .systemFont(ofSize: 12.0, weight: .regular)
        valueLabel.textColor = .black
        valueLabel.numberOfLines = 0

        let separator = UIView()
        separator.backgroundColor = .black
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

        let stackView = UIStackView(arrangedSubviews: [titleLabel, separator, valueLabel])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        container.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(stackView)

        contentView.addSubview(container)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4.0),
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 4.0),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4.0),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4.0),

            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func update(with title: String, value: String, row: Int) {

        container.backgroundColor = (row % 2) == 0 ? .white : UIColor.gray.withAlphaComponent(0.5)

        titleLabel.text = title
        valueLabel.text = value
    }
}
