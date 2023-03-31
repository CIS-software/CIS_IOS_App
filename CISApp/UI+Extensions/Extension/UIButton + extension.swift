import UIKit.UIButton

extension UIButton {
    static func makeBackArrowButton() -> UIButton {
        let button = UIButton()
        var arrowImage = UIImage(systemName: "arrow.backward")?.scaleImage(scaleFactor: 1.5)
        button.setImage(arrowImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
