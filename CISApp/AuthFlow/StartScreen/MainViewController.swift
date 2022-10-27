import UIKit

class MainViewController: UIViewController {
    
    var mainCardViewController = MainCardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.bgColor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainCardViewController.transitioningDelegate = self
        mainCardViewController.modalPresentationStyle = .custom
        mainCardViewController.toLoginCard = {[weak self] in  self?.presentLoginCard() }
        self.present(mainCardViewController, animated: true)
    }
    
    func presentLoginCard() {
        let loginCardVC = MainCardViewController()
        loginCardVC.transitioningDelegate = self
        loginCardVC.modalPresentationStyle = .custom
        self.present(loginCardVC, animated: true)
    }
    
    func presentRegisterCard() {
        mainCardViewController.transitioningDelegate = self
        mainCardViewController.modalPresentationStyle = .custom
        self.present(mainCardViewController, animated: true)
    }
    
    func makeTitleView() {
        
    }
    
    func makeTitleViewConstraints() {
        
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation(direction: .left, duration: 0.5)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation(direction: .bottom, duration: 0.5)
    }
}
