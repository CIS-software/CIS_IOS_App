import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
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
        let loginCardVC = LoginCardViewController(presentDirection: .left,
                                                  dismissDirection: .bottom,
                                                  presentDuration: 0.6,
                                                  dismissDuration: 0.6)
        loginCardVC.authCoordinator = self
        navigationController.present(loginCardVC, animated: true)
    }
    
    func toRegisterCard() {
        let registerVC = RegisterCardViewController(presentDirection: .left,
                                                 dismissDirection: .bottom,
                                                 presentDuration: 0.6,
                                                 dismissDuration: 0.6)
        registerVC.authCoordinator = self
        navigationController.present(registerVC, animated: true)
    }
    
    func toMainCard() {
        let mainCardVC = MainCardViewController(presentDirection: .bottom,
                                                dismissDirection: .left,
                                                presentDuration: 0.6,
                                                dismissDuration: 0.6)
        mainCardVC.authCoordinator = self
        navigationController.viewControllers.last?.present(mainCardVC, animated: true)
    }
    
    
}
