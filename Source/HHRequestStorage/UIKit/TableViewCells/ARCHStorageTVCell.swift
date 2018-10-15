//
//  TableViewCells.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class ARCHStorageTVCell: UITableViewCell, ARCHCell {

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let stackView = UIStackView()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        let container = configureContainer()
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

    // MARK: - Configuration

    private func configureContainer() -> UIView {

        let container = UIView()
        container.backgroundColor = .lightGray
        container.clipsToBounds = true
        container.layer.cornerRadius = 6.0

        titleLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = "REQUEST"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        dateLabel.font = .systemFont(ofSize: 11.0, weight: .medium)
        dateLabel.textColor = .black
        dateLabel.textAlignment = .right
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 2.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let separator = UIView()
        separator.backgroundColor = .darkGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

        [titleLabel, dateLabel, separator, stackView].forEach({ container.addSubview($0) })

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.0),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.0),

            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.0),
            dateLabel.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor, constant: 12.0),
            dateLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),

            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.0),
            separator.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.0),

            stackView.topAnchor.constraint(equalTo: separator.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.0),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.0),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.0)
        ])

        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        return container
    }

    // MARK: - ARCHCell

    var viewModel: ARCHStorageTVCellViewModel?

    func render(viewModel: ARCHStorageTVCellViewModel) {

        stackView.arrangedSubviews.forEach({
            self.stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })

        dateLabel.text = viewModel.requestDate

        stackView.addArrangedSubview(rowView(for: "Path", value: viewModel.path))
        stackView.addArrangedSubview(rowView(for: "Method", value: viewModel.method))
        stackView.addArrangedSubview(rowView(for: "Status code", value: viewModel.statusCode))
        stackView.addArrangedSubview(rowView(for: "Received at", value: viewModel.responseDate))
    }

    // MARK: - Private

    private func rowView(for title: String, value: String) -> UIView {
        return ARCHStorageTVCellRowView(title: title, value: value, titleWidthRatio: 0.3)
    }
}

private class ARCHStorageTVCellRowView: UIView {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    init(title: String, value: String, titleWidthRatio: CGFloat) {
        super.init(frame: .zero)

        let ratio = (titleWidthRatio > 0.0 && titleWidthRatio < 1.0) ? titleWidthRatio : 0.5

        titleLabel.font = .systemFont(ofSize: 11.0, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.text = "\(title):"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        valueLabel.font = .systemFont(ofSize: 11.0, weight: .regular)
        valueLabel.textColor = .black
        valueLabel.numberOfLines = 0
        valueLabel.text = value
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: ratio)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
