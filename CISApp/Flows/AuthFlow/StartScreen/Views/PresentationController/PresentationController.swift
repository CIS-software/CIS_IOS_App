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
    }
}
