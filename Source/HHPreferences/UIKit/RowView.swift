//
//  RowView.swift
//  HHPreferences
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

protocol RowViewOutput {

    func didChange(_ value: String, for name: String)

    func didSelectItem(_ name: String )
}

class RowView: UIView {

    var output: RowViewOutput?

    var name: String {
        return titleLabel.text ?? ""
    }

    private let titleLabel = UILabel()
    private let switchControll = UISwitch()
    private let valueLabel = UILabel()
    private let textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        titleLabel.textColor = .black

        valueLabel.font = .systemFont(ofSize: 12.0, weight: .regular)
        valueLabel.textColor = .black

        textField.font = .systemFont(ofSize: 12.0, weight: .regular)
        textField.tintColor = .black
        textField.textColor = .black

        let separator = UIView()
        separator.backgroundColor = UIColor.gray

        [titleLabel, valueLabel, separator, switchControll, textField].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),

            separator.heightAnchor.constraint(equalToConstant: 1.0),
            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),

            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.topAnchor.constraint(greaterThanOrEqualTo: separator.bottomAnchor),
            valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: switchControll.leadingAnchor, constant: -8.0),

            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(greaterThanOrEqualTo: separator.bottomAnchor),
            textField.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: switchControll.leadingAnchor, constant: -8.0),

            switchControll.topAnchor.constraint(greaterThanOrEqualTo: separator.bottomAnchor),
            switchControll.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            switchControll.trailingAnchor.constraint(equalTo: trailingAnchor),
            switchControll.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor)
        ])

        switchControll.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        switchControll.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        valueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc
    private func switchControllHandler(_ sender: UISwitch) {
        output?.didSelectItem(name)
    }

    @objc
    private func textFieldHandler(_ sender: UITextField) {
        output?.didChange(sender.text ?? "", for: name)
    }

    // MARK: - Public

    public func update(preference: Preference) {

        textField.isHidden = preference.type == .constant
        textField.text = preference.value
        textField.isEnabled = preference.isSelected

        valueLabel.isHidden = preference.type == .custom
        valueLabel.text = preference.value
        valueLabel.textColor = preference.isSelected ? .black : .gray

        titleLabel.text = preference.name
        titleLabel.textColor = preference.isSelected ? .black : .gray

        switchControll.isOn = preference.isSelected
    }
}
