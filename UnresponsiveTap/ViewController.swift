//
// 
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Actions
    @IBAction func didTapOpenUIKitBottomSheet(_ sender: Any) {
        let onHeaderTapGesture: (() -> Void) = { [weak self] in
            self?.dismiss(animated: true)
        }
        let childViewController = UIKitContentViewController(onHeaderTapAction: onHeaderTapGesture)
        let containerViewController = ContainerViewController(viewController: childViewController)
        self.present(containerViewController, animated: true)
    }

    @IBAction func didTapOpenSwiftUIBottomSheet(_ sender: Any) {
        let onHeaderTapGesture: (() -> Void) = { [weak self] in
            self?.dismiss(animated: true)
        }
        let childViewController = UIHostingController(rootView: SwiftUIContentView(onHeaderTapAction: onHeaderTapGesture))
        let containerViewController = ContainerViewController(viewController: childViewController)
        self.present(containerViewController, animated: true)
    }
}

private extension ViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        descriptionLabel.text = """
The bottom sheet can be closed by tapping on the orange header or swiping down over the orange header.

The problem is that SwiftUI stops to accept tap gestures if closing with the swipe down gesture was canceled.

Steps to reproduce the issue:

1. Open the bottom sheet

2. Start closing it with the swipe gesture over the orange header

3. Cancel the swipe-down action

4. Tap on the orange header

Is the bottom sheet closed?
Expected: Yes
Actual: No

"""
    }
}
