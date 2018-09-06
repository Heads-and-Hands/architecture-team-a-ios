//
//  CustomAnimationPresentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationPresentViewController<Out: CustomAnimationPresentViewOutput>: ARCHViewController<CustomAnimationPresentState, Out>, UIViewControllerTransitioningDelegate {

    let button = CustomButton(title: "PRESENT")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(button)

        button.addTarget(self, action: #selector(self.closeButtonDidTap(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0)
        ])

        transitioningDelegate = self
    }

    override func render(state: State) {
        super.render(state: state)
    }

    // MARK: - Animation

    @objc
    private func closeButtonDidTap(_ sender: UIButton) {
        output?.didTapCloseButton()
    }

    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimator(animationDuration: 1.5, isPresented: false)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimator(animationDuration: 1.5, isPresented: true)
    }
}
