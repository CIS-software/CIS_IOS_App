import Foundation

extension UserDefaults {
    public enum SavedKeys: String, CaseIterable {
        case userId
        case accessToken
        case refreshToken
        case password
        case login
    }
    
    static func setValue(_ value: Int?, key: SavedKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func setValue(_ value: String?, key: SavedKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getStrValue(forKey key: SavedKeys) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func getIntValue(forKey key: SavedKeys) -> Int? {
        UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static func reset() {
        SavedKeys.allCases.forEach { standard.removeObject(forKey: $0.rawValue) }
     }
}
