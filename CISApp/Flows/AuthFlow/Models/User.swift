import Foundation

public struct User {
    var name: String? = nil
    var surname: String? = nil
    var town: String? = nil
    var age: String? = nil
    var email: String? = nil
    var id: Int? = nil
    var belt: String? = nil
    var weight: Int? = nil
    var id_iko: String? = nil
}

struct UserApiResponse {
    let access_token: String?
    let refresh_token: String?
    let id: Int?
}

extension UserApiResponse: Decodable {
    private enum UserApiResponseCodingKeys: String, CodingKey {
        case id
        case access_token = "access-token"
        case refresh_token = "refresh-token"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserApiResponseCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        access_token = try container.decode(String.self, forKey: .access_token)
        refresh_token = try container.decode(String.self, forKey: .refresh_token)
    }
    
}

extension User: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case name
        case surname
        case town
        case age
        case email
        case id
        case belt
        case weight
        case id_iko
    }
    public init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserCodingKeys.self)
        
        name = try userContainer.decode(String.self, forKey: .name)
        surname = try userContainer.decode(String.self, forKey: .surname)
        town = try userContainer.decode(String.self, forKey: .town)
        age = try userContainer.decode(String.self, forKey: .age)
        email = try userContainer.decode(String.self, forKey: .email)
        id = try userContainer.decode(Int.self, forKey: .id)
        belt = try userContainer.decode(String.self, forKey: .belt)
        weight = try userContainer.decode(Int.self, forKey: .weight)
        id_iko = try userContainer.decode(String.self, forKey: .id_iko)
    }
}
