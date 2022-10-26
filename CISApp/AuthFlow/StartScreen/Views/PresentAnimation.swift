import Foundation
import UIKit

class PresentAnimation: NSObject {
    let duration: TimeInterval = 1.6
    
    let direction: PresentationDirections
    
    init(direction: PresentationDirections) {
        self.direction = direction
        super.init()
    }

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // transitionContext.view содержит всю нужную информацию, извлекаем её
        let to = transitionContext.view(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!) // Тот самый фрейм, который мы задали в PresentationController
        // Смещаем контроллер за границу экрана
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
            to.frame = finalFrame // Возвращаем на место, так он выезжает снизу
        }

        animator.addCompletion { (position) in
        // Завершаем переход, если он не был отменён
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
