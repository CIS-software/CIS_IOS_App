import Foundation

class RegistrationViewModel {
    
    public var userData: Observable<User?> = Observable(nil)
    
    var registrationStatus: Observable<RegistrationStatus> = Observable(.unsuccess)
    
    var cities = ["Верхняя Салда", "Нижняя Салда"]
    
    var userNetworkManager: UserNetworkManager?
    
    public func updateUserData() {
        
    }
    
}

extension RegistrationViewModel {
    enum RegistrationStatus {
        case sucessEmailAndPasswordEntered
        case sucessAllDataEntered
        case unsuccess
    }
}
