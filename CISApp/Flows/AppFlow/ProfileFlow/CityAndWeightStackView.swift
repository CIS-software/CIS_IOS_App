import UIKit

class CityAndWeightStackView: UIStackView {
    typealias ViewModel = CityAndWeightStackViewModel
    
    public var viewModel = ViewModel()
    
    public func bind() {
        viewModel.city.bind(listener: { [weak self] city in
            DispatchQueue.main.async {
                self?.cityLabel.text = city
            }
        })
        
        viewModel.weight.bind(listener: { [weak self] weight in
            DispatchQueue.main.async {
                self?.weightLabel.text = "\(weight)"
            }
        })
    }
    
    init () {
        super.init(frame: .zero)
        
        addArrangedSubview(geoImageView)
        addArrangedSubview(cityLabel)
        addArrangedSubview(weightImageView)
        addArrangedSubview(weightLabel)
        
        axis = .horizontal
        spacing = 5
        
        bind()
        
        translatesAutoresizingMaskIntoConstraints = false
        

    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let weightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "weightIcon"))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let geoImageView: UIImageView = {
        let geoImageView = UIImageView(image: UIImage(named: "geoAlt"))
        
        geoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        geoImageView.contentMode = .scaleAspectFit
        
        return geoImageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "", withFont: FontLib.Text16.regualr, color: .black)
        
        return label
        
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel.makeStandartLabel(text: "", withFont: FontLib.Text16.regualr, color: .black)
        
        return label
    }()
}
