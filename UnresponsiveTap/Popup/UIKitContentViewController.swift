//
//
//

import UIKit

final class UIKitContentViewController: UIViewController {

    lazy private var header: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()

    lazy private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()

    private var label = UILabel(frame: .zero)
    private var onHeaderTapAction: (() -> Void)

    init(onHeaderTapAction: @escaping (() -> Void)) {
        self.onHeaderTapAction = onHeaderTapAction
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        setupUI()
        setupConstraints()
    }

    // MARK: - Action
    @objc func onHeaderTap() {
        onHeaderTapAction()
    }
}

// MARK: - Private methods
private extension UIKitContentViewController {
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onHeaderTap))
        self.header.addGestureRecognizer(tapGesture)
    }

    func setupUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Tap here or swipe down to dismiss"
    }

    func setupConstraints() {
        label.frame = header.bounds
        header.addSubview(label)
        view.addSubview(header)
        view.addSubview(contentView)

        NSLayoutConstraint.activate([
            // Title label
            label.topAnchor.constraint(equalTo: header.topAnchor, constant: 4.0),
            label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -4.0),
            label.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 20.0),
            label.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -20.0),

            // Header
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leftAnchor.constraint(equalTo: view.leftAnchor),
            header.rightAnchor.constraint(equalTo: view.rightAnchor),

            // Content
            contentView.topAnchor.constraint(equalTo: header.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])


        let heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 400)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
}
