import Foundation
import UIKit

class RegisterCardViewController: CardViewController {
    typealias ViewModel = RegistrationViewModel
    
    var authCoordinator: AuthCoordinator?
    
    var viewModel: ViewModel?
    
    //MARK: UI
    
    private let backButton: UIButton  = {
        let button = UIButton()
        var arrowImage = UIImage(systemName: "arrow.backward")?.scaleImage(scaleFactor: 1.5)
        button.setImage(arrowImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.register,
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
    
    private let nextStepButton: StandartButton = {
        let button = StandartButton(title: Localization.AuthFlow.nextStep)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: ViewDidload
    
    override func viewDidLoad() {
        view.backgroundColor = .appColor(.formBgColor)
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindEvents()
        moveContentWhenKeyboardShows()
        backButton.addTarget(self, action: #selector(onBackButtonPressed), for: .touchUpInside)
        nextStepButton.addTarget(self, action: #selector(onNextButtonPressed), for: .touchUpInside)
        addViews()
        makeConstraints()
    }
    
    func eventHandler(status: ViewModel.RegistrationStatus) {
        switch status {
        case .sucessEmailAndPasswordEntered:
            self.dismiss(animated: true) { [weak self] in
                self?.authCoordinator?.toPersonalDataInput()
            }
        case .unsuccess(let error):
            let alert = UIAlertController(title: Localization.error, message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Localization.ok, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        default:
            return
        }
    }
    
    //MARK: Binded functions
    
    @objc private func onBackButtonPressed() {
        self.dismiss(animated: true) { [weak self] in
            self?.authCoordinator?.toMainCard()
        }
    }
    
    @objc private func onNextButtonPressed() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
                  viewModel?.registrationStatus.value = .unsuccess(error: Localization.AuthFlow.notEnouthAuthData)
                  return
        }
        
        viewModel?.userData.email = email
        viewModel?.password = password
        viewModel?.registrationStatus.value = .sucessEmailAndPasswordEntered
    }
    
    func bindEvents() {
        viewModel?.registrationStatus.bind(listener: {[weak self] status in
            guard let status = status else { return }
            self?.eventHandler(status: status)
        })
    }
    
    //MARK: - Constraints, SubViews adding
    
    private func addViews() {
        view.addSubviews([
            backButton,
            titleLabel,
            emailLabel,
            emailField,
            passwordLabel,
            passwordField,
            nextStepButton,
        ])
    }
    
    private func makeConstraints() {
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
        
        nextStepButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nextStepButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 25).isActive = true
        
        viewBottomConstraint = nextStepButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        viewBottomConstraint?.isActive = true
    }
    
}
