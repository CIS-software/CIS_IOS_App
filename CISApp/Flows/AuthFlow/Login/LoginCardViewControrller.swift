import UIKit

class LoginCardViewController: CardViewController {
    
    typealias ViewModel = LoginCardViewModel
    
    var authCoordinator: AuthCardsCoordinatorProtocol?
    
    var viewModel: ViewModel?
    
    //MARK: - UI
    private let backButton = UIButton.makeBackArrowButton()
    
    private let titleLabel = UILabel.makeStandartLabel(text: Localization.AuthFlow.enter,
                                                       withFont: FontLib.Title.cardTitle,
                                                       color: .appColor(.blackFontColor))
    
    
    private let emailLabel = UILabel.makeStandartLabel(text: Localization.AuthFlow.email,
                                                       withFont: FontLib.Text18.regualr,
                                                       color: .appColor(.blackFontColor))
    private let emailField: TextField = {
        let textField = TextField()
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordLabel = UILabel.makeStandartLabel(text: Localization.AuthFlow.password,
                                                          withFont: FontLib.Text18.regualr,
                                                          color: .appColor(.blackFontColor))
    
    private let passwordField: TextField = {
        let textField = TextField()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton = StandartButton(title: Localization.AuthFlow.enter)
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appColor(.formBgColor)
        addViews()
        bindData()
        hideKeyboardWhenTappedAround()
        moveContentWhenKeyboardShows()
        backButton.addTarget(self, action: #selector(onBackButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(onLoginButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Binded functions
    @objc private func onBackButtonPressed() {
        self.dismiss(animated: true) { [weak self] in
            self?.authCoordinator?.toMainCard()
        }
    }
    
    @objc private func onLoginButtonPressed() {
        viewModel?.updateCredentials(login: emailField.text ?? "", password: passwordField.text ?? "")
        
        switch viewModel?.creditionalsInput() {
        case .correct:
            viewModel?.loginUser()
        case .incorrect:
            return
        case .none:
            return
        }
    }
    
    func bindData() {
        viewModel?.creditionalsInputErrorMessage.bind( listener: { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Localization.error, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Localization.ok, style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true)
            }
        } )
        viewModel?.loginStatus.bind( listener: { [weak self] status in
            self?.event(status: status)
        } )
    }
    
    func event(status: ViewModel.LoginStatus) {
        switch status {
        case .success:
            DispatchQueue.main.async { [weak self] in
                self?.dismiss(animated: true) { [weak self] in
                    self?.authCoordinator?.toMainFlow()
                }
            }
        case .loading:
            DispatchQueue.main.async { [weak self] in
                self?.authCoordinator?.showLoadingVC()
            }
        case .unsuccess:
            DispatchQueue.main.async { [weak self] in
                self?.authCoordinator?.hideLoadingVC()
            }
            return
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
