//
//  Views.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 12/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

class ARCHStorageCellView: UIView {

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let stackView = UIStackView()

    init(title: String) {
        super.init(frame: .zero)

        backgroundColor = .gray
        clipsToBounds = true
        layer.cornerRadius = 6.0

        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = title

        dateLabel.font = UIFont.systemFont(ofSize: 8.0, weight: .bold)
        dateLabel.textColor = .black

        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        [titleLabel, dateLabel, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),

            dateLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 0.0),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            dateLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0)
        ])

        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    public func update(date: String, values: [String: String]) {
        dateLabel.text = date

        stackView.arrangedSubviews.forEach {
            self.stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        values.forEach { arg in
            let (key, value) = arg
            let view = ARCHRowView(title: key, content: value)
            self.stackView.addArrangedSubview(view)
        }
    }
}

private class ARCHRowView: UIView {

    private let titleLabel = UILabel()
    private let contentLabel = UILabel()

    // MARK: - Initialization

    init(title: String, content: String) {
        super.init(frame: .zero)

        backgroundColor = UIColor.lightGray
        clipsToBounds = true
        layer.cornerRadius = 6.0

        titleLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = title

        contentLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byCharWrapping
        contentLabel.text = content

        let separatorView = UIView()
        separatorView.backgroundColor = .darkGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        let container = UIStackView(arrangedSubviews: [titleLabel, separatorView, contentLabel])
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

        addSubview(container)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
