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
    }
}
