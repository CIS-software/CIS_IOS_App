import UIKit

class MainAppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let mainFlowTabBarController = MainTabBarViewController()
        let userProfileVC = UserProfileViewController()
        userProfileVC.coordinator = self
        userProfileVC.viewModel = UserProfileViewModel(networkManager: UserNetworkManager())
        
        userProfileVC.tabBarItem.image = UIImage(systemName: "person.fill")
        userProfileVC.tabBarItem.title = Localization.UserProfileFlow.title
        
        mainFlowTabBarController.viewControllers = [userProfileVC]
        navigationController.pushViewController(mainFlowTabBarController, animated: true)
    }
    
    func toLoginScreen() {
        navigationController.viewControllers = []
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    

    
}
