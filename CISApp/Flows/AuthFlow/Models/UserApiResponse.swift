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
