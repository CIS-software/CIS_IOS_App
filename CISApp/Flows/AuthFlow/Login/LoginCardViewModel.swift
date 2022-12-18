import Foundation

class LoginCardViewModel {
    
    var user: User?
    var email: String?
    var password: String?
    
    
    
}

extension LoginCardViewModel {
    enum State {
        case login
        case wrongUserData
    }
}
