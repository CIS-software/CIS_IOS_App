import UIKit.UITextField

class TextField: UITextField {
    
    private let textPadding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    init(placeholder: String? = nil) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 5
        font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textColor = UIColor.appColor(.blackFontColor)
        borderStyle = .none
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}

extension UITextField {
    func underlined(color:UIColor){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
