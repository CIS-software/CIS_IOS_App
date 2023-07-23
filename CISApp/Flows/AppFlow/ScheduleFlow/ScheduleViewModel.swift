class ScheduleViewModel {
    
    
}

final class ScheduleTableViewModel: AdaptedViewModelInputProtocol {
    var sections = [AdaptedSectionViewModelProtocol]()

    private func setupScheduleSection() {
        let section = AdaptedSectionViewModel(cells: [])
        
        sections.append(section)
    }
}
