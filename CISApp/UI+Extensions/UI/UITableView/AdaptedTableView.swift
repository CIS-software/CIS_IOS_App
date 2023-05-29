import UIKit

class AdaptedTableView: UITableView {
    
    // MARK: - Public properties
    
    var viewModel: AdaptedViewModelInputProtocol?
    var cellFactory: AdaptedCellFactoryProtocol? {
        didSet {
            cellFactory?.cellTypes.forEach({ $0.register(self) })
        }
    }
    
    // MARK: - Public methods
    
    func setup() {
        self.dataSource = self
    }
}

// MARK: - UITableViewDataSource

extension AdaptedTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].cells.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellFactory = cellFactory,
              let cellViewModel = viewModel?.sections[indexPath.section].cells[indexPath.row] else {
            return UITableViewCell()
        }
        
        // TODO: - Register cell
        // TODO: - Create cell
        
        return cellFactory.generateCell(viewModel: cellViewModel, tableView: self, for: indexPath)
    }
}
