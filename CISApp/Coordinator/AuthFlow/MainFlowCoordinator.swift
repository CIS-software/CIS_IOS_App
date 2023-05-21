import UIKit

class MainFlowCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var window: UIWindow
    
    var childCoordinators = [Coordinator]()
    var userProfileNavigationController = UINavigationController()
    var loadingViewController: LoadingViewController?
    
    init(window: UIWindow){
        self.window = window
    }
    
    func showLoadingScreen() {
        loadingViewController = LoadingViewController()
        loadingViewController?.modalPresentationStyle = .overCurrentContext
        loadingViewController?.modalTransitionStyle = .crossDissolve
        guard let loadingViewController = loadingViewController else { return }
        self.window.rootViewController?.present(loadingViewController, animated: true)
    }
    
    func start() {
        self.showLoadingScreen()
        if let email = UserDefaults.getStrValue(forKey: .login),
           let password = UserDefaults.getStrValue(forKey: .password) {
            tryAuth(email: email, password: password) {[weak self] success in
                if success {
                    DispatchQueue.main.async {
                        self?.loadingViewController?.dismiss(animated: true)
                        self?.showMainTabBar()
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self?.loadingViewController?.dismiss(animated: true)
                        self?.toLoginScreen()
                    }
                }
            }
        }
    }
    
    func showMainTabBar() {
        let mainFlowTabBarController = MainTabBarViewController()
        mainFlowTabBarController.viewControllers = [self.userProfileNavigationController]
        self.userProfileNavigationController.tabBarItem.image = UIImage(systemName: "person.fill")
        self.userProfileNavigationController.tabBarItem.title = Localization.UserProfileFlow.title
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.appColor(.bgColor)
            userProfileNavigationController.navigationBar.standardAppearance = appearance
            userProfileNavigationController.navigationBar.scrollEdgeAppearance = appearance
        }
        else {
            mainFlowTabBarController.tabBar.barTintColor = UIColor.appColor(.formBgColor)
            userProfileNavigationController.navigationBar.barTintColor = UIColor.appColor(.bgColor)
        }

        self.window.rootViewController = mainFlowTabBarController
        self.window.makeKeyAndVisible()
        self.showUserScreen()
    }
    
    func showUserScreen() {
        let userProfileVC = UserProfileViewController()
        
        userProfileVC.coordinator = self
        
        userProfileVC.viewModel = UserProfileViewModel(networkManager: UserNetworkManager())
        
        userProfileNavigationController.pushViewController(userProfileVC, animated: true)
    }
    
    func toLoginScreen() {
        let authCoordinator = AuthCoordinator(window: window)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
}

extension MainFlowCoordinator {
    func tryAuth(email: String, password: String, completion: @escaping (Bool) -> Void) {
        UserNetworkManager().loginUser(email: email, password: password) { id, acess, refresh, error in
            if let _ = error {
                completion(false)
                return
            }
            else {
                UserDefaults.setValue(id, key: .userId)
                UserDefaults.setValue(acess, key: .accessToken)
                UserDefaults.setValue(refresh, key: .refreshToken)
                
                completion(true)
                return
            }
        }
    }
}
