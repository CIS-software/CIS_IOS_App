import UIKit.UIStackView

extension UIStackView {
    func addBackground(with radius: CGFloat?, color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = radius ?? 0
        insertSubview(subView, at: 0)
    }
    
}
