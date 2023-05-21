import UIKit

class LoadingViewController: UIViewController {
    
    private let waitLabel = UILabel.makeStandartLabel(text: "Терпения, воин...", withFont: FontLib.Title.cardTitle, color: UIColor.appColor(.whiteFontColor))
    private let loadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.style = .large
        activityIndicator.color = .white
        
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()
    
    
    override func viewDidLoad() {
        layoutSubviews()
        makeConstraints()
    }
    
    private func layoutSubviews() {
        view.insertSubview(blurEffectView, at: 0)
        view.addSubview(loadingActivityIndicator)
        view.addSubview(waitLabel)
    }
    
    private func makeConstraints() {
        loadingActivityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadingActivityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        waitLabel.topAnchor.constraint(equalTo: loadingActivityIndicator.bottomAnchor, constant: 25).isActive = true
        waitLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    
        blurEffectView.centerXAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        blurEffectView.centerYAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        blurEffectView.widthAnchor.constraint(equalToConstant: (view.window?.screen.bounds.width ?? 400)/2).isActive = true
        blurEffectView.heightAnchor.constraint(equalToConstant: (view.window?.screen.bounds.height ?? 600)/3).isActive = true
    }
    
}
