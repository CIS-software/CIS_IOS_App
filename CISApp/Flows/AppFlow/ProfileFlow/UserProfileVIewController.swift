import UIKit

class UserProfileViewController: UIViewController {
    typealias ViewModel = UserProfileViewModel
    
    public var viewModel: ViewModel?
    
    public var coordinator: MainFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubviews()
        makeConstraints()
        
        layoutInfoCardViews()
        makeInfoCardConstraints()

        bindEvents()
        
        title = Localization.UserProfileFlow.title

        viewModel?.state.value = .initial
        
        view.backgroundColor = .white
        
        backBarButtonItem.target = self
        backBarButtonItem.action = #selector(onExitButtonTapped)
        
        navigationItem.rightBarButtonItem = backBarButtonItem
    }
    
    private let backBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.image = UIImage(systemName: "door.right.hand.open")
        barButtonItem.tintColor = UIColor.appColor(.whiteFontColor)
        
        return barButtonItem
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "userPlaceholder"))
        imageView.layer.borderColor = UIColor.appColor(.formBgColor)?.cgColor
        imageView.layer.borderWidth = 5
        imageView.layer.cornerRadius = imageView.frame.width/2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let userInfoСardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appColor(.formBgColor)
        
        view.layer.cornerRadius = 15

        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = .init(width: 0, height: 4)
        
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "",
                                              withFont: FontLib.Title.cardTitle,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "",
                                              withFont: FontLib.Text16.regualr,
                                              color: .appColor(.blackFontColor))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityAndWeightStackView = CityAndWeightStackView()
    
    private let sportsCategotyView = SportsCategoryView(for: .vertical)
    
    private func layoutSubviews() {
        view.addSubviews([  userInfoСardView,
                         ])
    }
    
    private func layoutInfoCardViews() {
        userInfoСardView.addSubviews([avatarImageView,
                                      userNameLabel,
                                      ageLabel,
                                      cityAndWeightStackView,
                                      sportsCategotyView
                                     ])
    }
    
    private func makeInfoCardConstraints() {
        avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: userInfoСardView.centerXAnchor).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: userInfoСardView.topAnchor).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
        
        cityAndWeightStackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        cityAndWeightStackView.centerXAnchor.constraint(equalTo: userInfoСardView.centerXAnchor).isActive = true
        
        ageLabel.topAnchor.constraint(equalTo: cityAndWeightStackView.bottomAnchor, constant: 10).isActive = true
        ageLabel.centerXAnchor.constraint(equalTo: userInfoСardView.centerXAnchor).isActive = true

        sportsCategotyView.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10).isActive = true
        sportsCategotyView.centerXAnchor.constraint(equalTo: userInfoСardView.centerXAnchor).isActive = true
        sportsCategotyView.bottomAnchor.constraint(equalTo: userInfoСardView.bottomAnchor, constant: -15).isActive = true
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
                self?.ageLabel.text = "\(Localization.UserProfileFlow.age):  \(user.age ?? Localization.UserProfileFlow.noData)"
                self?.userNameLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
                self?.cityAndWeightStackView.viewModel.weight.value = user.weight ?? 0
                self?.cityAndWeightStackView.viewModel.city.value = user.town ?? Localization.UserProfileFlow.noData
                if let belt = user.belt {
                    self?.sportsCategotyView.viewModel.gradeCategoty.value = belt.isEmpty ? Localization.UserProfileFlow.noData : belt
                }
                else {
                    self?.sportsCategotyView.viewModel.gradeCategoty.value = Localization.UserProfileFlow.noData
                }
                self?.sportsCategotyView.viewModel.gradeNum.value = 12
                self?.sportsCategotyView.viewModel.gradeCategoty.value = Localization.UserProfileFlow.noData
            }
        })
        viewModel?.state.bind(listener: {[weak self] state in
            self?.event(state: state)
        })
    }
    
    private func makeConstraints() {
        userInfoСardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        userInfoСardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true

    }
    
}
