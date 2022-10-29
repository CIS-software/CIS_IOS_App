import UIKit

class MainViewController: UIViewController {
    
    var mainCardViewController = MainCardViewController()
    
    var authCoordinator: AuthCoordinator?
    
    var logoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        
        let logoImage = UIImageView()
        let logoLabel = UILabel()
        
        logoImage.image = UIImage(named: "logo")
        logoLabel.text = Localization.titleCaps
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

class TransitioningDelegate: NSObject {
    let presentDirection: PresentationDirections
    let presentDuration: TimeInterval
    
    let dismissDirection: PresentationDirections
    let dismissDuration: TimeInterval
    
    init(presentDirection: PresentationDirections, presentDuration: TimeInterval, dismissDirection: PresentationDirections, dismissDuration: TimeInterval) {
        self.presentDirection = presentDirection
        self.presentDuration = presentDuration
        self.dismissDirection = dismissDirection
        self.dismissDuration = dismissDuration
    }
}


extension TransitioningDelegate: UIViewControllerTransitioningDelegate {
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
