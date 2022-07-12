//
//
//

import UIKit

final class ContainerViewController: UIViewController {

    private let viewController: UIViewController
    private var dismissInteractionController: CardSheetDismissInteractionController?    

    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.dismissInteractionController = CardSheetDismissInteractionController(viewController: self)
        self.embedChildViewController()
        self.setupUI()
        self.setupConstraints()
    }
}

extension ContainerViewController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return PopupPresentationController(presentedViewController: presented,
                                           presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardSheetPresentAnimationController()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardSheetDismissAnimationController(dismissInteractionController: dismissInteractionController)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactionController = dismissInteractionController,
              interactionController.isInteractionInProgress else {
            return nil
        }
        return interactionController
    }
}

private extension ContainerViewController {

    func embedChildViewController() {
        self.addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    func setupUI() {
        self.viewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.viewController.view.layer.cornerRadius = Constant.Style.standardCornerRadius
    }

    func setupConstraints() {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
