import Foundation

class UserProfileViewModel {
    public var userData:Observable<User?> = Observable(nil)
    
    public var state: Observable<UserProfileViewModel.State> = Observable(.initial)
    
    private var networkManager: UserNetworkManager
    
    init(networkManager: UserNetworkManager) {
        self.networkManager = networkManager
    }
    
    public func getUserData() {
        guard let id = UserDefaults.getIntValue(forKey: .userId),
              let access = UserDefaults.getStrValue(forKey: .accessToken) else {
            self.state.value = .dataDosentLoaded(error: Localization.error)
            return
        }
        networkManager.getUserData(id: id, access: access) {[weak self] user, error in
            guard let error = error else{ 
                self?.userData.value = user
                self?.state.value = .dataLoaded
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.state.value = .dataDosentLoaded(error: error)
            }
        }
    }
    
    public func exit() {
        UserDefaults.reset()
    }
}

extension UserProfileViewModel {
    enum State {
        case initial
        case dataLoaded
        case dataDosentLoaded(error: String)
        case exit
    }
}
