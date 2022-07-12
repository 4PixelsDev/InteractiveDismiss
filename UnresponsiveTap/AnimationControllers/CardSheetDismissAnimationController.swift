//
//
//

import UIKit

final class CardSheetDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private weak var dismissInteractionController: CardSheetDismissInteractionController?

    init(dismissInteractionController: CardSheetDismissInteractionController? = nil) {
        self.dismissInteractionController = dismissInteractionController
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constant.Animation.defaultDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        let finalFrame = toVC.view.frame

        transitionContext.containerView.addSubview(fromVC.view)
        let transitionDuration = self.transitionDuration(using: transitionContext)

        let animationCompletion: ((Bool) -> Void)? = { _ in
            let success = !transitionContext.transitionWasCancelled
            if success {
                fromVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }

        UIView.animate(withDuration: transitionDuration,
                       animations: {
            fromVC.view.frame.origin.y = finalFrame.maxY
        }, completion: animationCompletion)
    }
}
