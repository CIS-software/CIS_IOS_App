import UIKit

class LoginCardViewController: CardViewController {
    
    typealias ViewModel = LoginCardViewModel

    var authCoordinator: AuthCoordinator?
    
//MARK: - UI
    private let backButton: UIButton  = {
        let button = UIButton()
        var arrowImage = UIImage(systemName: "arrow.backward")?.scaleImage(scaleFactor: 1.5)
        button.setImage(arrowImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.enter,
                                              withFont: FontLib.Title.cardTitle,
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.email,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.password,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let passwordField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: StandartButton = {
        let button = StandartButton(title: Localization.AuthFlow.enter)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
// MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appColor(.formBgColor)
        addViews()
        makeConstraints()
        hideKeyboardWhenTappedAround()
        moveContentWhenKeyboardShows()
        backButton.addTarget(self, action: #selector(onBackButtonPressed), for: .touchUpInside)
        }
    
    // MARK: - Binded functions
    @objc private func onBackButtonPressed() {
        self.dismiss(animated: true) { [weak self] in
            self?.authCoordinator?.toMainCard()
        }
    }
//MARK: - Constraints SubViews adding
    private func addViews(){
        view.addSubviews([
            backButton,
            titleLabel,
            emailLabel,
            emailField,
            passwordLabel,
            passwordField,
            loginButton
        ])
        makeConstraints()
    }
    
    private func makeConstraints(){
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        passwordLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 25).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 25).isActive = true
        
        viewBottomConstraint = loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        viewBottomConstraint?.isActive = true
    }
}
