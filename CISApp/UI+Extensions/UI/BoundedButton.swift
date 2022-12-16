import UIKit

final class BoundedArrowButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setup()
    }
    
    @objc func onTouchDown() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self?.backgroundColor = .gray
        })
    }
    
    @objc func onTouchUp() {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.transform = .identity
                self?.backgroundColor = UIColor.appColor(.bgColor)
            })

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let hInset: CGFloat = 25
        let vInset: CGFloat = 14
        
        contentEdgeInsets = UIEdgeInsets(top: vInset, left: hInset,
                                         bottom: vInset, right: hInset)
        
        layer.cornerRadius = 10
        
        
        
        setTitleColor(UIColor.appColor(.blackFontColor), for: .normal)
        addTarget(self, action: #selector(onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(onTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(onTouchUp), for: .touchUpOutside)
    }

}
