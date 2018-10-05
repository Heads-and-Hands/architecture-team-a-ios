//
//  CustomAnimationPresentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationPresentViewController<Out: CustomAnimationPresentViewOutput>: ARCHViewController<CustomAnimationPresentState, Out>, UIViewControllerTransitioningDelegate {

    var imageView = UIImageView()
    var closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.35)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2.0 / 3.0),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0 / 2.0),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        closeButton.setTitle("Close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(self.closeButtonDidTap(_:)), for: .touchUpInside)

        imageView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8.0)
        ])
    }

    override func render(state: State) {
        super.render(state: state)

        imageView.image = state.image
    }

    // ARCHInteractiveTransitionDelegate

    override var closeGestureRecognizer: UIGestureRecognizer? {
        return UIPanGestureRecognizer()
    }

    override func progress(for recognizer: UIGestureRecognizer) -> CGFloat {
        guard let recognizer = recognizer as? UIPanGestureRecognizer else {
            return 0.0
        }

        let maxTranslation: CGFloat = 200.0
        let verticalTranslation = Double(recognizer.translation(in: recognizer.view?.superview).y)
        let horizontalTranslation = Double(recognizer.translation(in: recognizer.view?.superview).x)
        let translation = CGFloat(sqrt(pow(verticalTranslation, 2.0) + pow(horizontalTranslation, 2.0)))

        return min(translation / maxTranslation, 1.0)
    }

    // ARCHTransitionAnimatorDelegate

    var contextImageView: UIImageView?

    override func willAnimateAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {
        contextImageView?.frame = imageView.frame
    }

    override func didAnimateAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {
        imageView.alpha = 1.0
        contextImageView?.removeFromSuperview()
    }

    override func willAnimateDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {
        guard let (_, frame) = toViewController.getContextData() as? (UIImage?, CGRect?) else {
            return
        }

        contextImageView?.frame = frame ?? .zero
    }

    override func didAnimateDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {
        contextImageView?.removeFromSuperview()
    }

    override func prepareForAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {

        guard let (image, frame) = fromViewController.getContextData() as? (UIImage?, CGRect?) else {
            return
        }

        imageView.alpha = 0.0

        let contextImageView = UIImageView(image: image)
        contextImageView.contentMode = .scaleAspectFill
        contextImageView.clipsToBounds = true
        contextImageView.frame = frame ?? .zero

        let container = context.containerView
        container.addSubview(contextImageView)

        self.contextImageView = contextImageView
    }

    override func didDisappearanceAnimationCanceled(context: UIViewControllerContextTransitioning, toViewController: UIViewController & ARCHTransitionAnimatorDelegate) {
        imageView.alpha = 1.0
    }

    override func prepareForDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {

        let contextImageView = UIImageView(image: imageView.image)
        contextImageView.contentMode = .scaleAspectFill
        contextImageView.clipsToBounds = true
        contextImageView.frame = imageView.frame

        let container = context.containerView
        container.addSubview(contextImageView)

        imageView.alpha = 0.0

        self.contextImageView = contextImageView
    }

    // MARK: - Private

    @objc
    private func closeButtonDidTap(_ sender: UIButton) {
        output?.didTapCloseButton()
    }
}
