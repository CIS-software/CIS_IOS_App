import Foundation

public enum CISApi {
    public enum Users {
        case login(email: String, password: String)
        case updateTokens(refresh_token: String)
        case createUser(name: String, surename: String, password: String, email: String, town: String, age: String)
        case user(id: Int, acessToken: String)
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
        case .user(let id, _):
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
        case .createUser(let name, let surename, let password, let email, let town, let age):
            return .requestParameters(bodyParameters: ["Email": email,
                                                       "Password": password,
                                                       "Name": name,
                                                       "Surename": surename,
                                                       "Town": town,
                                                       "Age": age],
                                      urlParameters: nil)
        case .user(_, let accessToken):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: ["Authorization": "Bearer " + accessToken])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
