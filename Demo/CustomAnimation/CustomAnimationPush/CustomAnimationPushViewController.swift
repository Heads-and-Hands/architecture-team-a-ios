//
//  CustomAnimationPushViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationPushViewController<Out: CustomAnimationPushViewOutput>: ARCHViewController<CustomAnimationPushState, Out> {

    let imageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func render(state: State) {
        super.render(state: state)

        imageView.image = state.image

        view.layoutIfNeeded()
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
}
