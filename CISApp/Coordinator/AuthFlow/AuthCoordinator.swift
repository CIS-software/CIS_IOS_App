import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let TD = TransitioningDelegate(presentDirection: .bottom, presentDuration: 0.6, dismissDirection: .left, dismissDuration: 0.6)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.authCoordinator = self
        navigationController.pushViewController(mainViewController, animated: false)
        toMainCard()
    }
}

extension AuthCoordinator: AuthCardsCoordinatorProtocol {
    func toLoginCard() {
        let loginCardVC = LoginCardViewController()
        loginCardVC.authCoordinator = self
        navigationController.present(loginCardVC, animated: true)
    }
    
    func toRegisterCard() {
        let registerVC = LoginCardViewController()
        navigationController.present(registerVC, animated: true)
    }
    
    func toMainCard() {
        let mainCardVC = MainCardViewController()
        mainCardVC.authCoordinator = self
        mainCardVC.transitioningDelegate = TD
        mainCardVC.modalPresentationStyle = .custom
        navigationController.present(mainCardVC, animated: true)
    }
    
    
}
