import UIKit
class PresentationController: UIPresentationController {
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let presentedView = presentedView else { return }
        containerView?.addSubview(presentedView)
        roundCorners(cornerRadius: 30)
        makeConstraints()
    }
    
    func roundCorners(cornerRadius: CGFloat) {
        presentedView?.layer.cornerRadius = cornerRadius
        presentedView?.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
    }
    
    func makeConstraints() {
        guard let presentedView = presentedView, let containerView = containerView else { return }
        
        presentedView.translatesAutoresizingMaskIntoConstraints = false
        presentedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        presentedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        presentedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.bottomAnchor.constraint(equalTo: presentingViewController.view.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: presentingViewController.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: presentingViewController.view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: presentedView.heightAnchor).isActive = true
    }
}
