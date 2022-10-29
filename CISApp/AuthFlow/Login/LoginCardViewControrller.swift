import UIKit

class LoginCardViewController: UIViewController {

    var authCoordinator: AuthCoordinator?
//MARK: - Private Variables
    private var transDelegate: TransitioningDelegate? {
        didSet{
            self.transitioningDelegate = transDelegate
        }
    }
    
    private var viewBottomConstraint: NSLayoutConstraint?
//MARK: - UI
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
    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setTransitioningDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appColor(.formBgColor)
        addSubwiews()
        makeConstraints()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
// MARK: - Binded functions
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            viewBottomConstraint?.constant -= keyboardSize.height + 40
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
            viewBottomConstraint?.constant = 0
            updateViewConstraints()
        }
//MARK: - Constraints SubViews adding
    private func addSubwiews(){
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        makeConstraints()
    }
    
    private func makeConstraints(){
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
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 50).isActive = true
        
        viewBottomConstraint = loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        viewBottomConstraint?.isActive = true
    }
    
    private func setTransitioningDelegate() {
        let transitioningDelegate = TransitioningDelegate(presentDirection: .bottom, presentDuration: 0.6, dismissDirection: .left, dismissDuration: 0.6)
        self.transDelegate = transitioningDelegate
        self.modalPresentationStyle = .custom
    }
}
