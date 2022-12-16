import Foundation

public struct User {
    var name: String
    var surename: String
    var town: String
    var age: String
    var email: String
    var password: String
}

struct UserApiResponse {
//    let name: String?
//    let surename: String?
//    let town: String?
//    let age: String?
//    let email: String?
    let access_token: String?
    let refresh_token: String?
    let id: Int?
//    let belt: String?
//    let weight: Int?
//    let id_iko: String?
}

extension UserApiResponse: Decodable {
    private enum UserApiResponseCodingKeys: String, CodingKey {
//        case name = "name"
//        case surename = "surename"
//        case town = "town"
//        case age = "age"
//        case email = "email"
        case id = "id"
        case access_token = "access-token"
        case refresh_token = "refresh-token"
//        case belt
//        case weight
//        case id_iko
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserApiResponseCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        access_token = try container.decode(String.self, forKey: .access_token)
        refresh_token = try container.decode(String.self, forKey: .refresh_token)
//
//        belt = container.decode(String.self, forKey: .belt)
//        weight = container.decode(Int.self, forKey: .weight)
//        id_iko = container.decode(String.self, forKey: .id_iko)
//        name = container.decode(String.self, forKey: .name)
//        surename = container.decode(String.self, forKey: .surename)
//        town = container.decode(String.self, forKey: .town)
//        age = container.decode(String.self, forKey: .age)
//        email = container.decode(String.self, forKey: .email)
        
    }
    
}

extension User: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case name = "Name"
        case surename = "Surename"
        case town = "Town"
        case age = "Age"
        case email = "Email"
        case password = "Password"
    }
    public init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserCodingKeys.self)
        
        name = try userContainer.decode(String.self, forKey: .name)
        surename = try userContainer.decode(String.self, forKey: .surename)
        town = try userContainer.decode(String.self, forKey: .town)
        age = try userContainer.decode(String.self, forKey: .age)
        email = try userContainer.decode(String.self, forKey: .email)
        password = try userContainer.decode(String.self, forKey: .password)
    }
}
