import UIKit

class PersonalDataRegistrationCardViewController: CardViewController {
    
    typealias ViewModel = RegistrationViewModel
    
    var authCoordinator: AuthCardsCoordinatorProtocol?
    
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
    
    private let firstNameLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.firstName,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let firstNameField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.lastName,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let lastNameField: TextField = {
        let textField = TextField()
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.сityToTrain,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let cityTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let cityPicker: UIPickerView = {
        let cityPicker = UIPickerView()
        return cityPicker
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.AuthFlow.birthDay, withFont: FontLib.Text.regualr, color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.layer.backgroundColor = UIColor.appColor(.blackFontColor)?.cgColor
        datePicker.layer.cornerRadius = 10
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
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
        moveContentWhenKeyboardShows()
        bindEvents()
        cityTextField.inputView = cityPicker
        cityPicker.dataSource = self
        cityPicker.delegate = self
        backButton.addTarget(self, action: #selector(onBackButtonPressed), for: .touchUpInside)
        nextStepButton.addTarget(self, action: #selector(onNextButtonPressed), for: .touchUpInside)
        addViews()
        makeConstraints()
    }
    
    //MARK: Binded functions
    
    @objc private func onBackButtonPressed() {
        self.dismiss(animated: true) { [weak self] in
            self?.authCoordinator?.toMainCard()
        }
    }
    
    @objc private func onNextButtonPressed() {
        guard let name = firstNameField.text, !name.isEmpty,
              let surname = lastNameField.text, !surname.isEmpty,
              let town = cityTextField.text, !town.isEmpty else {
            viewModel?.registrationStatus.value = .unsuccess(error: Localization.AuthFlow.notEnouthAuthData)
            return
        }
        let birhday = getChoosenBirthday()
        viewModel?.userData.name = name
        viewModel?.userData.surname = surname
        viewModel?.userData.town = town
        viewModel?.userData.age = birhday
        viewModel?.registrationStatus.value = .sucessAllDataEntered
    }
    
    func getChoosenBirthday() -> String {
        let dateFormatter = DateFormatter()
        let birthday = birthDatePicker.date
        dateFormatter.dateFormat = "YY/MM/dd"
        
        return dateFormatter.string(from: birthday)
    }
    
    func bindEvents() {
        self.viewModel?.registrationStatus.bind(listener: {[weak self] state in
            guard let state = state else {return}
            self?.event(state: state)
        })
    }
    
    func event(state: ViewModel.RegistrationStatus) {
        switch state {
        case .sucessAllDataEntered:
            viewModel?.registerUser()
        case .unsuccess(error: let error):
            let alert = UIAlertController(title: Localization.error, message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Localization.ok, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        case .registrationSucess:
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    self.authCoordinator?.toLoginCard()
                }
            }
        default:
            return
        }
    }
    
    //MARK: - Constraints, SubViews adding
    
    private func addViews() {
        view.addSubviews([
            backButton,
            titleLabel,
            firstNameLabel,
            firstNameField,
            lastNameLabel,
            lastNameField,
            cityLabel,
            cityTextField,
            birthdayLabel,
            birthDatePicker,
            nextStepButton,
        ])
        makeConstraints()
    }
    
    private func makeConstraints() {
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        firstNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        firstNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        firstNameField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 10).isActive = true
        firstNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        firstNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        lastNameLabel.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 25).isActive = true
        lastNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        lastNameField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 10).isActive = true
        lastNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        lastNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 25).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        cityTextField.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        birthdayLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 25).isActive = true
        birthdayLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        birthDatePicker.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 10).isActive = true
        birthDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        nextStepButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nextStepButton.topAnchor.constraint(equalTo: birthDatePicker.bottomAnchor, constant: 25).isActive = true
        
        viewBottomConstraint = nextStepButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        viewBottomConstraint?.isActive = true
    }
}


extension PersonalDataRegistrationCardViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel?.cities.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.cities[row] ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityTextField.text = viewModel?.cities[row] ?? ""
        cityTextField.resignFirstResponder()
    }
}
