import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var registrationViewModel: RegistrationViewModel?
    
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
                                                  presentDuration: 0.4,
                                                  dismissDuration: 0.4)
        loginCardVC.authCoordinator = self
        loginCardVC.viewModel = LoginCardViewModel(networkLoginManager: UserNetworkManager())
        navigationController.present(loginCardVC, animated: true)
    }
    
    func toRegisterCard() {
        let registerVC = RegisterCardViewController(presentDirection: .left,
                                                 dismissDirection: .bottom,
                                                 presentDuration: 0.4,
                                                 dismissDuration: 0.4)
        registerVC.authCoordinator = self
        registrationViewModel = RegistrationViewModel()
        registrationViewModel?.userNetworkManager = UserNetworkManager()
        registerVC.viewModel = registrationViewModel
        navigationController.present(registerVC, animated: true)
    }
    
    func toPersonalDataInput() {
        let personalDataRegisterVC = PersonalDataRegistrationCardViewController(presentDirection: .left,
                                                                                dismissDirection: .right,
                                                                                presentDuration: 0.4,
                                                                                dismissDuration: 0.4)
        personalDataRegisterVC.viewModel = registrationViewModel
        personalDataRegisterVC.authCoordinator = self
        navigationController.present(personalDataRegisterVC, animated: true)
    }
    
    func toMainCard() {
        let mainCardVC = MainCardViewController(presentDirection: .bottom,
                                                dismissDirection: .left,
                                                presentDuration: 0.4,
                                                dismissDuration: 0.4)
        mainCardVC.authCoordinator = self
        navigationController.viewControllers.last?.present(mainCardVC, animated: true)
    }
    
    
}
