import UIKit
import Foundation

class CardViewController: UIViewController {
    private let presentDirection, dismissDirection: PresentationDirections
    private let presentDuration, dismissDuration: TimeInterval
    
    var keyboardIsShown: Bool = false
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

extension CardViewController {
    func moveContentWhenKeyboardShows() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, !keyboardIsShown {
            viewBottomConstraint?.constant -= keyboardSize.height
            keyboardIsShown = true
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        viewBottomConstraint?.constant = 0
        keyboardIsShown = false
        updateViewConstraints()
    }
}
