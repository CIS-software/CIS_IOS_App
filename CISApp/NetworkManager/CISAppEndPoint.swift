import Foundation

public enum CISApi {
    public enum Users {
        case login(email: String, password: String)
        case updateTokens(refresh_token: String)
        case createUser(user: User)
        case user(id: Int)
    }
}

extension CISApi.Users: EndpointTypeProtocol {
    var baseURL: URL {
        guard let baseUrl = URL(string: "http://127.0.0.1:8080/") else { fatalError("baseURL could not be configured.") }
        return baseUrl
    }
    var path: String {
        switch self {
            
        case .login:
            return "login"
        case .updateTokens:
            return "update-tokens"
        case .createUser:
            return "create-user"
        case .user(let id):
            return "user/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            
        case .login:
            return .post
        case .updateTokens:
            return .post
        case .createUser:
            return .post
        case .user:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
            
        case .login(let email, let password):
            return .requestParameters(bodyParameters: ["Email": email, "Password": password], urlParameters: nil)
        case .updateTokens(let refresh_token):
            return .requestParameters(bodyParameters: ["refresh-token": refresh_token], urlParameters: nil)
        case .createUser(let user):
            return .requestParameters(bodyParameters: ["Email": user.email,
                                                       "Password": user.password,
                                                       "Name": user.name,
                                                       "Surename": user.surename,
                                                       "Town": user.town,
                                                       "Age": user.age],
                                      urlParameters: nil)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
