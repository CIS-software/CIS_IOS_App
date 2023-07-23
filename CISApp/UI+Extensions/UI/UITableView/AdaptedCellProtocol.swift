import UIKit

protocol AdaptedCellProtocol {
    static var identifier: String { get }
    static var nib: UINib { get }
    static func register(_ tableView: UITableView)
    static func reuse(_ tableView: UITableView, for indexPath: IndexPath) -> Self
}

extension AdaptedCellProtocol {
    static var identifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    static func reuse(_ tableView: UITableView, for indexPath: IndexPath) -> Self {
        tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Self
    }
}
