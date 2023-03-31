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
        case userId
    }
    public init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserCodingKeys.self)
        
        name = try userContainer.decode(String.self, forKey: .name)
        surname = try userContainer.decode(String.self, forKey: .surname)
        town = try userContainer.decode(String.self, forKey: .town)
        age = try userContainer.decode(String.self, forKey: .age)
//        email = try userContainer.decode(String.self, forKey: .email)
        id = try userContainer.decode(Int.self, forKey: .userId)
        belt = try userContainer.decode(String.self, forKey: .belt)
        weight = try userContainer.decode(Int.self, forKey: .weight)
        id_iko = try userContainer.decode(String.self, forKey: .id_iko)
    }
}
