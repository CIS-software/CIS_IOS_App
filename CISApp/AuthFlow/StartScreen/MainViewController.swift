import UIKit

class MainViewController: UIViewController {
    
    var mainCardViewController = MainCardViewController()
    
    var logoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        
        let logoImage = UIImageView()
        let logoLabel = UILabel()
        
        logoImage.image = UIImage(named: "logo")
        logoLabel.text = "КАРАТЕ\nСАЛДА"
        logoLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        logoLabel.textColor = UIColor.appColor(.whiteFontColor)
        logoLabel.numberOfLines = 2

        stackView.addArrangedSubview(logoImage)
        stackView.addArrangedSubview(logoLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.bgColor)
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainCardViewController.transitioningDelegate = self
        mainCardViewController.modalPresentationStyle = .custom
        mainCardViewController.toLoginCard = presentLoginCard
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
    
    func addSubviews() {
        view.addSubview(logoStackView)
        makeTitleViewConstraints()
    }
    
    func makeTitleViewConstraints() {
        logoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation(direction: .bottom, duration: 1.2)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation(direction: .left, duration: 0.6)
    }
}
