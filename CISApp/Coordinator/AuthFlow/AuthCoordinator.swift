import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    lazy var mainVC = MainViewController()
    
    let window: UIWindow
    
    var registrationViewModel: RegistrationViewModel?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.window.rootViewController = mainVC
        self.window.makeKeyAndVisible()
        mainVC.authCoordinator = self
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
        mainVC.present(loginCardVC, animated: true)
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
        mainVC.present(registerVC, animated: true)
    }
    
    func toPersonalDataInput() {
        let personalDataRegisterVC = PersonalDataRegistrationCardViewController(presentDirection: .left,
                                                                                dismissDirection: .right,
                                                                                presentDuration: 0.4,
                                                                                dismissDuration: 0.4)
        personalDataRegisterVC.viewModel = registrationViewModel
        personalDataRegisterVC.authCoordinator = self
        mainVC.present(personalDataRegisterVC, animated: true)
    }
    
    func toMainCard() {
        let mainCardVC = MainCardViewController(presentDirection: .bottom,
                                                dismissDirection: .left,
                                                presentDuration: 0.4,
                                                dismissDuration: 0.4)
        mainCardVC.authCoordinator = self
        mainVC.present(mainCardVC, animated: true)
    }
    
    func toMainFlow() {
        let mainFlowCoordinator = MainFlowCoordinator(window: window)
        self.mainVC.dismiss(animated: false)
        childCoordinators.append(mainFlowCoordinator)
        mainFlowCoordinator.start()
    }
    
    
}
