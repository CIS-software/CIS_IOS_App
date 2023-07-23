class AdaptedSectionViewModel: AdaptedSectionViewModelProtocol {
    var cells: [AdaptedCellViewModelProtocol]
    
    init (cells: [AdaptedCellViewModelProtocol]) {
        self.cells = cells
    }
}
