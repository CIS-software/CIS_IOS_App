import UIKit

protocol AdaptedCellFactoryProtocol {
    var cellTypes: [AdaptedCellProtocol.Type] { get }
    func generateCell(viewModel: AdaptedCellViewModelProtocol, tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}
