//
//
//

import UIKit

final class CardSheetDismissInteractionController: UIPercentDrivenInteractiveTransition {

    private enum Style {
        static let percentTrashold = 0.5
    }
    // MARK: - Private properties
    private weak var viewController: UIViewController?
    private var shouldFinish = false

    // MARK: - Public properties
    var isInteractionInProgress = false

    init(viewController: UIViewController?) {
        self.viewController = viewController
        super.init()
        self.setupGesture()
    }

    // MARK: - Private properties
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_ :)))
        viewController?.view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let view = viewController?.view else { return }

        let translation = recognizer.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downardMovement = max(verticalMovement, 0.0)
        let downardMovementPercent = min(downardMovement, 1.0)
        let progress = downardMovementPercent

        switch recognizer.state {
        case .began:
            isInteractionInProgress = true
            viewController?.dismiss(animated: true)
        case .changed:
            shouldFinish = progress > Style.percentTrashold
            update(progress)
        case .cancelled:
            isInteractionInProgress = false
            cancel()
        case .ended:
            isInteractionInProgress = false
            if shouldFinish {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
