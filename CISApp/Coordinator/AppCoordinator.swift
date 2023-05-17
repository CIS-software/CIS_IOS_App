import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private let window: UIWindow
    private var mainCoordinator: MainFlowCoordinator?
    private var authCoordinator: AuthCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if let _ = UserDefaults.getStrValue(forKey: .login),
           let _ = UserDefaults.getStrValue(forKey: .password) {
            mainCoordinator = MainFlowCoordinator(window: window)
            mainCoordinator?.start()
        }
        else {
            authCoordinator = AuthCoordinator(window: window)
            authCoordinator?.start()
        }
//        if let email = UserDefaults.getStrValue(forKey: .login),
//           let password = UserDefaults.getStrValue(forKey: .password) {
//            UserNetworkManager().loginUser(email: email, password: password) {[weak self] id, acess, refresh, error in
//                guard let error = error else {
//                    print("Opa")
//                    UserDefaults.setValue(id, key: .userId)
//                    UserDefaults.setValue(acess, key: .accessToken)
//                    UserDefaults.setValue(refresh, key: .refreshToken)
//
//                    let mainCoordinator = MainAppCoordinator(window: self?.window ?? UIWindow())
//
//                    self?.childCoordinators.append(mainCoordinator)
//
//                    DispatchQueue.main.async { [weak mainCoordinator] in
//                        print("Opa")
//                        mainCoordinator?.start()
//                    }
//                    return
//                }
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
//                    let alert = UIAlertController(title: Localization.error, message: error, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: Localization.ok, style: UIAlertAction.Style.default, handler: nil))
//
//                    let authCoordinator = AuthCoordinator(window: self.window)
//
//                    self.childCoordinators.append(authCoordinator)
//                    authCoordinator.start()
//
//                    DispatchQueue.main.async {
//                    }
//                }
//
//            }
//            return
//        }
//
//        let authCoordinator = AuthCoordinator(window: self.window)
//
//        childCoordinators.append(authCoordinator)
//        authCoordinator.start()
    }
}
