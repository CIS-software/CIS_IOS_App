import UIKit.UITableView

protocol CellFactoryProtocol {
    var cellTypes: [TableViewCellProtocol.Type] {get}
    func genearateCell(viewModel:CellViewModelProtocol, tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}
