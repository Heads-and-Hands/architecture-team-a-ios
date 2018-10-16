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
    private let separator = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        titleLabel.textColor = .black

        valueLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        valueLabel.textColor = .black

        textField.font = .systemFont(ofSize: 18.0, weight: .regular)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.tintColor = .black
        textField.textColor = .black
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        textField.layer.cornerRadius = 4.0
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.textFieldHandler(_:)), for: .editingChanged)

        switchControll.addTarget(self, action: #selector(self.switchControllHandler(_:)), for: .valueChanged)

        separator.backgroundColor = UIColor.gray

        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func layout() {
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
            valueLabel.centerYAnchor.constraint(equalTo: switchControll.centerYAnchor),

            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 4.0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: switchControll.leadingAnchor, constant: -8.0),

            switchControll.topAnchor.constraint(greaterThanOrEqualTo: separator.bottomAnchor, constant: 4.0),
            switchControll.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            switchControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.0)
        ])

        switchControll.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        switchControll.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        valueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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

        if !preference.isSelected {
            textField.resignFirstResponder()
        }

        valueLabel.isHidden = preference.type == .custom
        valueLabel.text = preference.value
        valueLabel.textColor = preference.isSelected ? .black : .gray

        titleLabel.text = preference.name
        titleLabel.textColor = preference.isSelected ? .black : .gray

        switchControll.setOn(preference.isSelected, animated: true)
    }
}

extension RowView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switchControll.setOn(true, animated: true)
        output?.didSelectItem(name)
    }
}
