import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    typealias ViewModel = UserProfileViewModel
    
    public var viewModel: ViewModel?
    
    public var coordinator: MainAppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Localization.UserProfileFlow.title
        bindEvents()
        layoutSubviews()
        MakeConstraints()
        viewModel?.state.value = .initial
        exitButton.addTarget(self, action: #selector(onExitButtonTapped), for: .touchUpInside)
    }
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel.makeStandartLabel(text: Localization.UserProfileFlow.title,
                                                   withFont: FontLib.Title.cardTitle,
                                                   color: .appColor(.blackFontColor))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "",
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageNoteLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.UserProfileFlow.age,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "",
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityNoteLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.UserProfileFlow.city,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "",
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightNoteLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.UserProfileFlow.weight,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "",
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beltNoteLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: Localization.UserProfileFlow.belt,
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beltLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "",
                                              withFont: FontLib.Text.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let exitButton: UIButton = {
        let button = StandartButton(title: Localization.UserProfileFlow.getOut)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func layoutSubviews() {
        view.addSubviews([userNameLabel,
                          titleLabel,
                          ageNoteLabel,
                          ageLabel,
                          cityNoteLabel,
                          cityLabel,
                          weightNoteLabel,
                          weightLabel,
                          beltNoteLabel,
                          beltLabel,
                          exitButton
                         ])
    }
    
    private func event(state: ViewModel.State){
        switch state {
        case .initial:
            viewModel?.getUserData()
        case .dataLoaded:
            return
        case .exit:
            viewModel?.exit()
            coordinator?.toLoginScreen()
        case .dataDosentLoaded(let error):
            DispatchQueue.main.async { [weak self] in
                let alert = UIAlertController(title: Localization.error, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Localization.ok, style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
    }
    
    @objc private func onExitButtonTapped() {
        viewModel?.state.value = .exit
    }
    
    private func bindEvents() {
        viewModel?.userData.bind(listener: { [weak self] user in
            DispatchQueue.main.async { [weak self] in
                guard let user = user else { return }
                self?.ageLabel.text = user.age
                self?.userNameLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
                self?.cityLabel.text = user.town
                self?.weightLabel.text = user.weight == nil ? Localization.UserProfileFlow.noData : String.init(describing: user.weight)
                self?.beltLabel.text = user.belt?.isEmpty ?? false ? Localization.UserProfileFlow.noData : user.belt
            }
        })
        viewModel?.state.bind(listener: {[weak self] state in
            self?.event(state: state)
        })
    }
    
    private func MakeConstraints() {
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        ageNoteLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 25).isActive = true
        ageNoteLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                              constant: -view.bounds.width/4).isActive = true
        ageLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 25).isActive = true
        ageLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                          constant: view.bounds.width/4).isActive = true
        
        cityNoteLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 25).isActive = true
        cityNoteLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                               constant: -view.bounds.width/4).isActive = true
        cityLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 25).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                           constant: view.bounds.width/4).isActive = true
        
        weightNoteLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 25).isActive = true
        weightNoteLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                                 constant: -view.bounds.width/4).isActive = true
        weightLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 25).isActive = true
        weightLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                             constant: view.bounds.width/4).isActive = true
        
        beltNoteLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 25).isActive = true
        beltNoteLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                               constant: -view.bounds.width/4).isActive = true
        beltLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 25).isActive = true
        beltLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                           constant: view.bounds.width/4).isActive = true
        
        exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        exitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
}
