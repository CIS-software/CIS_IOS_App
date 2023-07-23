import Foundation

struct UserNetworkManager {
    let router = Router<CISApi.Users>()
    
    enum NetworkResponse: String {
        case success
        case authError
        case badRequest = "Ошибка данных!"
        case outdated
        case failed
        case noData
        case unabletoDecode
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 400...499:
            return .failure(NetworkResponse.badRequest.rawValue)
        default:
            print(response.debugDescription)
            return .failure(response.debugDescription)
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (_ id: Int?, _ acess: String?, _ refresh: String?, _ error: String?) -> ()) {
        router.request( .login(email: email, password: password)){ data, response, error in
            if error != nil {
                completion(nil, nil, nil, error?.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, nil, nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UserApiResponse.self, from: responseData)
                        guard let id = apiResponse.id,
                              let access = apiResponse.access_token,
                              let refresh = apiResponse.refresh_token else { return }
                    
                        completion(id, access, refresh, nil)
                    } catch {
                        completion(nil, nil, nil, NetworkResponse.unabletoDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, nil, nil, networkFailureError)
                }
            }
        }
    }
    
    func createUser(name: String, surename: String, password: String, email: String, town: String, age: String,
                    completion: @escaping (_ user: User?,
                                           _ error: String?) -> ()) {
        router.request(.createUser(name: name, surename: surename, password: password, email: email, town: town, age: age)) { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, "No data")
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UserRegisterData.self, from: responseData)
                        guard let _ = apiResponse.id else { return }
                        completion(User(name: apiResponse.name, surname: apiResponse.surname, town: apiResponse.town, age: apiResponse.age, email: apiResponse.email, id: apiResponse.id, belt: apiResponse.belt, id_iko: apiResponse.id_iko), nil)
                    }
                    catch {
                        completion(nil, NetworkResponse.unabletoDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getUserData(id: Int, access: String, completion: @escaping (_ user: User?, _ error: String?)-> ()) {
        router.request(.user(id: id, acessToken: access)) { data, response, error in
               if error != nil {
                   completion(nil, error?.localizedDescription)
               }
               if let response = response as? HTTPURLResponse {
                   let result = self.handleNetworkResponse(response)
                   switch result {
                   case .success:
                       guard let responseData = data else {
                           completion(nil, "No data")
                           return
                       }
                       do {
                           let apiResponse = try JSONDecoder().decode(User.self, from: responseData)
                           guard let _ = apiResponse.id else { return }
                           completion(User(name: apiResponse.name, surname: apiResponse.surname, town: apiResponse.town, age: apiResponse.age, id: apiResponse.id, belt: apiResponse.belt, id_iko: apiResponse.id_iko), nil)
                       }
                       catch {
                           completion(nil, NetworkResponse.unabletoDecode.rawValue)
                       }
                   case .failure(let networkFailureError):
                       completion(nil, networkFailureError)
                   }
               }
        }
    }
}

