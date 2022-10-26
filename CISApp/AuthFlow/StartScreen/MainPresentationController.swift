import Foundation
import UIKit

class MainCardViewController: UIViewController {
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
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.appColor(.formBgColor)
        super.viewDidLoad()
        
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
        
        loginButton.widthAnchor.constraint(equalTo: registerButton.widthAnchor).isActive = true
        
        view.topAnchor.constraint(equalTo: loginButton.topAnchor, constant: 50).isActive = true
        
        view.bottomAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 50).isActive = true
    }
}
