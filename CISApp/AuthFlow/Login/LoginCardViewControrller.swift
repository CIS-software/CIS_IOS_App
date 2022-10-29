import UIKit

class LoginCardViewController: CardViewController {

    var authCoordinator: AuthCoordinator?
//MARK: - Private Variables
    
    private var viewBottomConstraint: NSLayoutConstraint?
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
                                              withFont: .systemFont(ofSize: 20, weight: .semibold),
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.email,
                                              withFont: .systemFont(ofSize: 18, weight: .semibold),
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.password,
                                              withFont: .systemFont(ofSize: 18, weight: .semibold),
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
        addSubwiews()
        makeConstraints()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        backButton.addTarget(self, action: #selector(onBackButtonPressed), for: .touchUpInside)
        }
// MARK: - Binded functions
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            viewBottomConstraint?.constant -= keyboardSize.height
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
            viewBottomConstraint?.constant = 0
            updateViewConstraints()
        }
    
    @objc private func onBackButtonPressed() {
        self.dismiss(animated: true) { [weak self] in
            self?.authCoordinator?.toMainCard()
        }
    }
//MARK: - Constraints SubViews adding
    private func addSubwiews(){
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
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
