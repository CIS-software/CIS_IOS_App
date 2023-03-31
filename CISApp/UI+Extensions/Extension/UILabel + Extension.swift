import Foundation
import UIKit

extension UILabel {
    static func makeStandartLabel(text: String, withFont font: UIFont, color: UIColor?) -> UILabel {
        let label = UILabel()
        label.font = font
        label.text = text
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
