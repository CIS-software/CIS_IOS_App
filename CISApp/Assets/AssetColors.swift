import UIKit.UIColor

enum AssetColors: String {
    case bgColor
    case formBgColor
    case whiteFontColor
    case blackFontColor
}

extension UIColor {
    static func appColor(_ name: AssetColors) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
