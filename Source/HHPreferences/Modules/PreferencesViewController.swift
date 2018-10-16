//
//  PreferencesViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class PreferencesViewController: ARCHViewController<PreferencesState, PreferencesEventHandler>, RowViewOutput {

    private let stackView = UIStackView()
    private let titleLable = UILabel()
    private let closeButton = UIButton()

    private var bottomConstraint: NSLayoutConstraint?

    // MARK: - Initialization/Deinitialization

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardNotificationHandler(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        titleLable.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        titleLable.textAlignment = .center

        closeButton.backgroundColor = .gray
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.clipsToBounds = true
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        closeButton.setTitle("Close", for: .normal)
        closeButton.layer.cornerRadius = 6.0
        closeButton.addTarget(self, action: #selector(self.closeButtonTapHandler(_:)), for: .touchUpInside)

        [closeButton, titleLable].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })

        if #available(iOS 11.0, *) {
            titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
            bottomConstraint = closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
            bottomConstraint?.isActive = true
        }

        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),

            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            closeButton.heightAnchor.constraint(equalToConstant: 36.0)
        ])

        configureScrollView()
    }

    // MARK: - Configuration

    private func configureScrollView() {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 8.0),
            scrollView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -8.0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0)
        ])

        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)

        titleLable.text = state.title

        state.preferences.forEach({ preference in
            view(for: preference.name).update(preference: preference)
        })
    }

    // MARK: - Actions

    @objc
    private func closeButtonTapHandler(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc
    private func keyboardNotificationHandler(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }

        let constant: CGFloat = endFrame.minY < closeButton.frame.maxY ? endFrame.height + 8.0 : 8.0

        bottomConstraint?.constant = -constant

        UIView.animate(withDuration: duration, animations: {
            self.view.layoutIfNeeded()
        })
    }

    // MARK: - Private

    private func view(for name: String) -> RowView {
        if let view = stackView.arrangedSubviews.compactMap({ $0 as? RowView })
            .first(where: { $0.name == name }) {
            return view
        }

        let view = RowView(frame: .zero)
        stackView.addArrangedSubview(view)
        view.output = self
        return view
    }

    // MARK: - RowViewOutput

    func didChange(_ value: String, for name: String) {
        output?.didChange(value, for: name)
    }

    func didSelectItem(_ name: String) {
        output?.didSelectItem(name)
    }
}
