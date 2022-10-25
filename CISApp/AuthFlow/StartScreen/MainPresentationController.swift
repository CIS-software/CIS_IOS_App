import Foundation
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

class MainCardViewController: UIViewController {
    var loginButton: UIButton = {
        let button = StandartButton(title: "Войти")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var registerButton: UIButton = {
        let button = StandartButton(title: "Зарегестрироваться")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.appColor(.formBgColor)
        super.viewDidLoad()
        
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        makeButtonsConstraints()
    }
    
    func makeButtonsConstraints() {
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50).isActive = true
        
        loginButton.widthAnchor.constraint(equalTo: registerButton.widthAnchor).isActive = true
        
        view.topAnchor.constraint(equalTo: loginButton.topAnchor, constant: 50).isActive = true
        
        view.bottomAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 50).isActive = true
    }
}

enum PresentationDirection {
    case top
    case left
    case right
    case bottom
}


class SlideInPresentationManager: NSObject {
    var direction: PresentationDirection = .bottom
    
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {

}
