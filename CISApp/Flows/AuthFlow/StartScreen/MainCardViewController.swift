import Foundation
import UIKit

class MainCardViewController: CardViewController {
    var authCoordinator: AuthCoordinator?
    
    var loginButton: UIButton = {
        let button = StandartButton(title: Localization.AuthFlow.enter)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var registerButton: UIButton = {
        let button = StandartButton(title: Localization.AuthFlow.register)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func loginButtonPressed() {
        self.dismiss(animated: true) { [weak self] in
            self?.authCoordinator?.toLoginCard()
        }
    }
    @objc func registerButtonPressed() {
        self.dismiss(animated: true) { [weak self] in
            self?.authCoordinator?.toRegisterCard()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.formBgColor)
        addViews()
    }
    
    func addViews() {
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
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
