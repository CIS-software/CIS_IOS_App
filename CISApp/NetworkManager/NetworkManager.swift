import Foundation

struct NetworkManager {
    let router = Router<CISApi.Users>()
    
    enum NetworkResponse: String {
        case success
        case authError
        case badRequest
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
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (_ id: Int?, _ acess: String?, _ refresh: String?, _ error: String?) -> ()) {
        router.request( .login(email: email, password: password)){ data, response, error in
            if error != nil {
                completion(nil, nil, nil, "CheckNetworkConnection")
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
}

