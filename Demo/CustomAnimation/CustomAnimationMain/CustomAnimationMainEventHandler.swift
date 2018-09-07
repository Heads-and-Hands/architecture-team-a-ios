//
//  CustomAnimationMainEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationMainEventHandler: ARCHEventHandler<CustomAnimationMainState>, CustomAnimationMainViewOutput, CustomAnimationMainModuleInput {

    weak var moduleOutput: CustomAnimationMainModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()

        fetchData()
    }

    func didTapPresentButton(_ image: UIImage) {
        guard let router = router else {
            return
        }

        let animator = CustomPresentAnimator()
        let interactor = CustomPresentInteractor()
        let animationsOption = ARCHRouterPresentCustomAnimationOptions(animatedTransitioning: animator, interactiveTransition: interactor)

        CustomAnimationPresentConfigurator(
            moduleIO: { (input: CustomAnimationPresentModuleInput) -> CustomAnimationPresentModuleOutput? in
                var moduleInput = input
                moduleInput.image = image
                return nil
        }).router.transit(from: router, options: [animationsOption, ARCHRouterPresentOptions()], animated: true)
    }

    func didTapPushButton(_ image: UIImage) {
    }

    // MARK: - Private

    private func fetchData() {

        for _ in 0 ..< 21 {
            fetchRandomImage(completion: { [weak self] image in
                guard let `self` = self else {
                    return
                }
                self.state.images.append(image)
            })
        }

    }

    private func fetchRandomImage(completion: ((_ image: UIImage) -> Void)?) {
        guard let url = URL(string: "https://picsum.photos/200/300?random") else {
            return
        }

        URLSession(configuration: .default).dataTask(
            with: url,
            completionHandler: { data, response, error in
                if let error = error {
                    print("LOG DEBUG: \(error.localizedDescription)")
                } else if let imageData = data {
                    DispatchQueue.main.async {
                        completion?(UIImage(data: imageData) ?? UIImage())
                    }
                } else {
                    print("LOG DEBUG: Could not load image")
                }
        }).resume()
    }
}
