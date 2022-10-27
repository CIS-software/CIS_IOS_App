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
        
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
}
