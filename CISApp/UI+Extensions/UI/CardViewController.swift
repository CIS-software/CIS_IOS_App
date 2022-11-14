import UIKit
import Foundation

class CardViewController: UIViewController {
    private let presentDirection, dismissDirection: PresentationDirections
    private let presentDuration, dismissDuration: TimeInterval
    
    var viewBottomConstraint: NSLayoutConstraint?
    
    init(presentDirection: PresentationDirections,
         dismissDirection: PresentationDirections,
         presentDuration: TimeInterval,
         dismissDuration: TimeInterval) {
        self.presentDirection = presentDirection
        self.presentDuration = presentDuration
        self.dismissDirection = dismissDirection
        self.dismissDuration = dismissDuration
        
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CardViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation(direction: presentDirection, duration: presentDuration)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation(direction: dismissDirection, duration: dismissDuration)
    }
}
