import UIKit

class SportsCategoryView: UIStackView {
    typealias ViewModel = SportsCategoryViewModel
    
    public var viewModel = ViewModel()
    
    init(for orientation: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        
        addArrangedSubview(gradeNumLabel)
        addArrangedSubview(dividerView)
        addArrangedSubview(gradeCategoryLabel)
        
        axis = orientation
        spacing = 5

        bind()
        
        if orientation == .horizontal {
            dividerView.widthAnchor.constraint(equalToConstant: 5).isActive = true
            dividerView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
        else {
            dividerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            dividerView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        }
        
        addBackground(with: 5, color: .white)
        
        alignment = .center
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 2
        layer.shadowOffset = .init(width: 0, height: 4)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.gradeNum.bind { [weak self] gradeNum in
            DispatchQueue.main.async {
                self?.gradeNumLabel.text = "\(gradeNum)"
            }
        }
        
        viewModel.gradeCategoty.bind { [weak self] gradeCategoty in
            DispatchQueue.main.async {
                self?.gradeCategoryLabel.text = gradeCategoty
            }
        }
    }
    
    private let gradeNumLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "", withFont: FontLib.Text16.bold, color: UIColor.appColor(.blackFontColor))
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return label
    }()
    
    private let gradeCategoryLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "", withFont: FontLib.Text16.bold, color: UIColor.appColor(.blackFontColor))
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return label
    }()
    
    private let dividerView: UIView = {
        let div = UIView()
        div.backgroundColor = .black
        div.translatesAutoresizingMaskIntoConstraints = false
        
        return div
    }()
}
