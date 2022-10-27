import Foundation
import UIKit

class PresentAnimation: NSObject {
    let duration: TimeInterval
    
    let direction: PresentationDirections
    
    init(direction: PresentationDirections, duration: TimeInterval) {
        self.direction = direction
        self.duration = duration
        super.init()
    }

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let to = transitionContext.view(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
        switch direction {
        case .bottom:
            to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        case .top:
            to.frame = finalFrame.offsetBy(dx: 0, dy: -finalFrame.height)
        case .left:
            to.frame = finalFrame.offsetBy(dx: -finalFrame.width, dy: 0)
        case .right:
            to.frame = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
        }

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            to.frame = finalFrame
        }

        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
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
