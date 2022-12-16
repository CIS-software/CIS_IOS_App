import UIKit

protocol CellViewModelProtocol { }

protocol SectionViewModelProtocol {
    var cells: [CellViewModelProtocol] { get }
}

protocol InputViewModelProtocol {
    var sections: [SectionViewModelProtocol] { get }
}
