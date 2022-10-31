import UIKit.UIFont

enum FontLib {
    enum Title {
        static let title = UIFont.systemFont(ofSize: 32, weight: .semibold)
        static let cardTitle = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    enum Text {
        static let bold = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let semibold = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let regualr = UIFont.systemFont(ofSize: 18, weight: .regular)
        static let medium = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
}
