import UIKit.UIFont

enum FontLib {
    enum Title {
        static let title = UIFont.systemFont(ofSize: 32, weight: .semibold)
        static let cardTitle = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    enum Text18 {
        static let bold = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let semibold = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let regualr = UIFont.systemFont(ofSize: 18, weight: .regular)
        static let medium = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    enum Text16 {
        static let bold = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let semibold = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let regualr = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let medium = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}
