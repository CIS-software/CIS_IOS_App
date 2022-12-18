import Foundation

extension UserDefaults {
    public enum SavedKeys: String {
        case accessToken
        case refreshToken
        case password
        case login
    }
    
    static func setValue(_ value: String?, key: SavedKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getValue(forKey key: SavedKeys) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
}
