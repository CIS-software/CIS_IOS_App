import Foundation
import UIKit

class DismissAnimation: NSObject {
    let duration: TimeInterval = 0.4
    
    let direction: PresentationDirections

    init(direction: PresentationDirections) {
        self.direction = direction
        super.init()
    }
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let from = transitionContext.view(forKey: .from)!
        let initialFrame = transitionContext.initialFrame(for: transitionContext.viewController(forKey: .from)!)
        
        var fromeFrame: CGRect
        
        switch direction {
        case .bottom:
            fromeFrame = initialFrame.offsetBy(dx: 0, dy: initialFrame.height)
        case .top:
            fromeFrame = initialFrame.offsetBy(dx: 0, dy: -initialFrame.height)
        case .left:
            fromeFrame = initialFrame.offsetBy(dx: -initialFrame.width, dy: 0)
        case .right:
            fromeFrame = initialFrame.offsetBy(dx: initialFrame.width, dy: 0)
        }

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            from.frame = fromeFrame
        }

        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

extension DismissAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}
