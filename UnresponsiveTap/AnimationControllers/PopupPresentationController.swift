//
//
//

import UIKit

final class PopupPresentationController: UIPresentationController {

    lazy private var dimmingView: UIView = {
        let dimmingView = UIView()

        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = .black.withAlphaComponent(0.8)
        dimmingView.alpha = 0.0

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
        dimmingView.isAccessibilityElement = true

        return dimmingView
    }()

    // MARK: - Override
    override func presentationTransitionWillBegin() {
        guard let containerView = self.containerView else { return }

        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds

        self.presentingViewController.beginAppearanceTransition(false, animated: true)

        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 1.0
            self.presentedView?.layer.cornerRadius = Constant.Style.standardCornerRadius
            self.presentingViewController.endAppearanceTransition()
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
            self.presentedView?.layer.cornerRadius = Constant.Style.standardCornerRadius
        }, completion: { _ in
            self.presentingViewController.endAppearanceTransition()
        })
    }

    override func dismissalTransitionWillBegin() {
        self.presentingViewController.beginAppearanceTransition(true, animated: true)

        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 0.0
            self.presentingViewController.endAppearanceTransition()
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }, completion: { _ in
            self.presentingViewController.endAppearanceTransition()
        })
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        let fullSize = self.size(forChildContentContainer: presentedViewController,
                                 withParentContainerSize: containerView?.bounds.size ?? .zero)

        var size = presentedViewController
            .view
            .systemLayoutSizeFitting(CGSize(width: fullSize.width, height: 1.0),
                                     withHorizontalFittingPriority: .required,
                                     verticalFittingPriority: .fittingSizeLevel)

        let height = ceil(size.height + self.presentingViewController.view.safeAreaInsets.bottom)
        let fullHeight = fullSize.height - self.presentingViewController.view.safeAreaInsets.top

        size = CGSize(width: round(fullSize.width),
                      height: height > fullHeight ? fullHeight : height)

        let origin = CGPoint(x: 0.0, y: fullSize.height - size.height)

        return CGRect(origin: origin, size: size)
    }

    override func containerViewWillLayoutSubviews() {
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }

    // MARK: - Actions
    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true)
    }
}
