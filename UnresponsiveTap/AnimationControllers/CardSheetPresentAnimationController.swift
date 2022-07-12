//
//
//

import UIKit

final class CardSheetPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private enum Style {
        static let transitionDuration: CGFloat = 0.30
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Style.transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
        }

        var finalFrame = transitionContext.finalFrame(for: toVC)
        finalFrame.origin.y = finalFrame.size.height

        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.frame = finalFrame

        UIView.performWithoutAnimation {
            toVC.view.layoutIfNeeded()
        }

        finalFrame.origin.y = 0.0

        let animations = {
            toVC.view.frame = finalFrame
        }

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        })
    }
}
