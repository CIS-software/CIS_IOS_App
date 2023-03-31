import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private let window: UIWindow
    
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        self.window = window
    }
    
    
    func start() {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if let email = UserDefaults.getStrValue(forKey: .login),
           let password = UserDefaults.getStrValue(forKey: .password) {
            UserNetworkManager().loginUser(email: email, password: password) {[weak self] id, acess, refresh, error in
                guard let error = error else {
                    guard let self = self else { return }
                    UserDefaults.setValue(id, key: .userId)
                    UserDefaults.setValue(acess, key: .accessToken)
                    UserDefaults.setValue(refresh, key: .refreshToken)
                    let mainCoordinator = MainAppCoordinator(navigationController: self.navigationController)
                    mainCoordinator.parentCoordinator = AuthCoordinator(navigationController: self.navigationController)
                    self.childCoordinators.append(mainCoordinator)
                    DispatchQueue.main.async { [weak mainCoordinator] in
                        mainCoordinator?.start()
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
//                    let alert = UIAlertController(title: Localization.error, message: error, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: Localization.ok, style: UIAlertAction.Style.default, handler: nil))
//
                    let authCoordinator = AuthCoordinator(navigationController: self.navigationController)
                    
                    self.childCoordinators.append(authCoordinator)
                    authCoordinator.start()
                    
//                    let window = UIApplication.shared.keyWindow
//                    let rootViewController = window?.rootViewController
//                    rootViewController?.present(alert, animated: true, completion: nil)
                }

            }
            return
        }
        
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
}
