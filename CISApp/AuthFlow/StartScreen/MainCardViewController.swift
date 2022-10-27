import Foundation
import UIKit

class MainCardViewController: UIViewController {
    typealias VoidHandler = ()->Void
    
    var toLoginCard: VoidHandler?
    var toRegisterCard: VoidHandler?
    
    var loginButton: UIButton = {
        let button = StandartButton(title: "Войти")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var registerButton: UIButton = {
        let button = StandartButton(title: "Зарегестрироваться")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func dismissController() {
        self.dismiss(animated: true) { [weak self] in
            self?.toLoginCard?()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.formBgColor)
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        makeButtonsConstraints()
    }
    
    func makeButtonsConstraints() {
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
        loginButton.widthAnchor.constraint(equalTo: registerButton.widthAnchor).isActive = true
    }
}
