//
//  TextFieldController.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHInputField

class TextFieldController: ARCHInputFieldViewController<ARCHInputFieldEventHandler> {

    private let stackView = UIStackView()
    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldInsets = UIEdgeInsets(top: 15.0, left: 5.0, bottom: 15.0, right: 5.0)
    }

    override func prepareRootView() {
        super.prepareRootView()

        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        errorLabel.font = UIFont.systemFont(ofSize: 11.0)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
    }

    // MARK: - Configuration

    override func configureLayout(label: UILabel, textFieldContainer: UIView) {
        [label, textFieldContainer, errorLabel].forEach({
            self.stackView.addArrangedSubview($0)
        })
    }

    override func configure(textField: UITextField) {
        super.configure(textField: textField)

        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress

        if let container = textField.superview {
            container.backgroundColor = .lightGray
            container.clipsToBounds = true
            container.layer.cornerRadius = 6.0
        }
    }

    override func configure(label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 14.0)
    }

    override func configure(for validationResult: ARCHTextValidationResult) {
        super.configure(for: validationResult)

        errorLabel.text = validationResult.errorDescription

        if validationResult.isValid && !errorLabel.isHidden {
            animateErrorDisappearance(error: validationResult.errorDescription)
        } else if !validationResult.isValid && errorLabel.isHidden {
            animateErrorAppearance(error: validationResult.errorDescription)
        }
    }

    // MARK: - Animation

    private func animateErrorAppearance(error: String) {
        errorLabel.alpha = 0.0

        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.errorLabel.isHidden = false
                self.textFieldContainer.layer.borderColor = UIColor.red.cgColor
                self.textFieldContainer.layer.borderWidth = 2.0
            },
            completion: { _ in
                UIView.animate(withDuration: 0.25, animations: { self.errorLabel.alpha = 1.0 })
            })
    }

    private func animateErrorDisappearance(error: String) {
        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.errorLabel.alpha = 0.0
                self.textFieldContainer.layer.borderColor = UIColor.clear.cgColor
                self.textFieldContainer.layer.borderWidth = 0.0
            },
            completion: { _ in
                UIView.animate(withDuration: 0.25, animations: { self.errorLabel.isHidden = true })
            })
    }
}
