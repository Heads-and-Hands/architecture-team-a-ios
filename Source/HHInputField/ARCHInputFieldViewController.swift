//
//  ARCHInputFieldViewController.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

open class ARCHInputFieldViewController<Out: ARCHInputFieldViewOutput>:
ARCHViewController<ARCHInputFieldState, Out>, UITextFieldDelegate {

    public let textFieldContainer = UIView()
    public let textField = UITextField()
    public let label = UILabel()

    public var textFieldInsets = UIEdgeInsets() {
        didSet {
            configure(textField: textField)
        }
    }

    private var currentRange: NSRange?
    private var oldLength: Int = 0

    override open func prepareRootView() {
        super.prepareRootView()

        configure(textField: textField)
        configure(label: label)
        configureLayout(label: label, textFieldContainer: textFieldContainer)
    }

    open override func render(state: ARCHInputFieldState) {
        super.render(state: state)

        textField.text = state.value
        label.text = state.label

        configure(placeholder: state.placeholder)
        configure(for: state.validationResult)
        moveCursorIfNeeded()
    }

    // MARK: - Configuration

    open func configure(textField: UITextField) {
        textField.delegate = self

        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.removeFromSuperview()

        textFieldContainer.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: textFieldInsets.left),
            textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -textFieldInsets.right),
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldInsets.top),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldInsets.bottom)
        ])

        textFieldContainer.setNeedsLayout()
    }

    open func configure(label: UILabel) {
    }

    open func configure(placeholder: String) {
        textField.placeholder = placeholder
    }

    open func configureLayout(label: UILabel, textFieldContainer: UIView) {

        [label, textFieldContainer].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            textFieldContainer.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8.0),
            textFieldContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textFieldContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.layoutIfNeeded()
    }

    open func configure(for validationResult: ARCHTextValidationResult) {
    }

    // MARK: - Private

    private func moveCursorIfNeeded() {
        let increment = (textField.text ?? "").count - oldLength
        oldLength = (textField.text ?? "").count

        guard let range = currentRange, increment != 0 else {
            return
        }

        let offset = range.upperBound + increment

        if let position = textField.position(from: textField.beginningOfDocument, offset: offset) {
            textField.selectedTextRange = textField.textRange(from: position, to: position)
        }
    }

    // MARK: - UITextFieldDelegate

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        return false
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (((textField.text ?? "") as NSString).mutableCopy() as? NSMutableString) ?? NSMutableString()
        text.deleteCharacters(in: range)

        if !string.isEmpty {
            text.insert(string, at: range.location)
        }

        currentRange = range

        output?.shouldChange(text: text as String)

        return false
    }
}
