import Foundation

class RegistrationViewModel {
    
    public var userData: User = User()
    
    public var password: String? = nil
    
    var registrationStatus: Observable<RegistrationStatus?> = Observable(nil)
    
    var cities = ["Верхняя Салда", "Нижняя Салда"]
    
    var userNetworkManager: UserNetworkManager?
    
    func registerUser() {
        guard let name = userData.name,
              let surename = userData.surname,
              let password = password,
              let email = userData.email,
              let town = userData.town,
              let age = userData.age
        else {
            registrationStatus.value = .unsuccess(error: Localization.AuthFlow.notEnouthAuthData)
            return
        }
        userNetworkManager?.createUser(name: name, surename: surename, password: password, email: email, town: town, age: age, completion: {[weak self] user, error in
            guard let error = error else {
                UserDefaults.setValue(email, key: .login)
                UserDefaults.setValue(password, key: .password)
                self?.registrationStatus.value = .registrationSucess
                return
            }
            DispatchQueue.main.async {
                self?.registrationStatus.value = .unsuccess(error: error)
            }
            return
        })
    }
    
}

extension RegistrationViewModel {
    enum RegistrationStatus {
        case registrationSucess
        case sucessEmailAndPasswordEntered
        case sucessAllDataEntered
        case unsuccess(error: String)
    }
}
