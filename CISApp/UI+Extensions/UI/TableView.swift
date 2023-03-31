import UIKit.UITableView

class TableView: UITableView {
    
    var viewModel: InputViewModelProtocol?
    var cellFactory: CellFactoryProtocol? {
        didSet {
            cellFactory?.cellTypes.forEach({ $0.register(self)})
        }
    }
    
    func setup() {
        dataSource = self
    }
}

extension TableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].cells.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cellFactory = cellFactory,
            let cellViewModel = viewModel?.sections[indexPath.section].cells[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        return cellFactory.genearateCell(viewModel: cellViewModel, tableView: tableView, for: indexPath)
    }
    
    
}
