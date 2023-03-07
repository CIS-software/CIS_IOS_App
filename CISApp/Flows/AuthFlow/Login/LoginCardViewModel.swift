import Foundation

class LoginCardViewModel {
    private let networkLoginManager: UserNetworkManager
    
    private var login = ""
    private var password = ""
    
    public var loginStatus: Observable<LoginStatus> = Observable(LoginStatus.unsuccess)
    
    private var creditionals = UserCreditionals() {
        didSet {
            login = creditionals.login
            password = creditionals.password
        }
    }
    
    var creditionalsInputErrorMessage: Observable<String> = Observable("")
    
    init(networkLoginManager: UserNetworkManager) {
        self.networkLoginManager = networkLoginManager
    }
    
    func updateCredentials(login: String, password: String) {
        creditionals.login = login
        creditionals.password = password
    }
    
    func loginUser() {
        networkLoginManager.loginUser(email: login, password: password) {[weak self] id, acess, refresh, error in
            guard let error = error else {
                UserDefaults.setValue(id, key: .userId)
                UserDefaults.setValue(self?.login, key: .login)
                UserDefaults.setValue(self?.password, key: .password)
                UserDefaults.setValue(acess, key: .accessToken)
                UserDefaults.setValue(refresh, key: .refreshToken)
                self?.loginStatus.value = .success
                return
            }
                self?.creditionalsInputErrorMessage.value = error
        }
    }
    
    func creditionalsInput() -> CreditionalsInputStatus {
        if login.isEmpty && password.isEmpty {
            creditionalsInputErrorMessage.value = Localization.AuthFlow.notEnouthAuthData
            return .incorrect
        }
        if login.isEmpty {
            creditionalsInputErrorMessage.value = Localization.AuthFlow.loginFiewldEmpty
            return .incorrect
        }
        if password.isEmpty {
            creditionalsInputErrorMessage.value = Localization.AuthFlow.passwordFieldEmty
            return .incorrect
        }
        return .correct
    }
}

extension LoginCardViewModel {
    enum CreditionalsInputStatus {
        case correct
        case incorrect
    }
    enum LoginStatus {
        case success
        case unsuccess
    }
}
