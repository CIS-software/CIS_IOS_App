import UIKit

class MainViewController: UIViewController {
    
    var authCoordinator: AuthCoordinator?
    
    //MARK: - UI
    
    private let logoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        
        let logoImage = UIImageView()
        let logoLabel = UILabel()
        
        logoImage.image = UIImage(named: "logo")
        logoLabel.text = Localization.titleCaps
        logoLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        logoLabel.textColor = UIColor.appColor(.whiteFontColor)
        logoLabel.numberOfLines = 2

        stackView.addArrangedSubview(logoImage)
        stackView.addArrangedSubview(logoLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.bgColor)
        addViews()
    }
    
    func addViews() {
        view.addSubview(logoStackView)
        makeTitleViewConstraints()
    }
    
    func makeTitleViewConstraints() {
        logoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


