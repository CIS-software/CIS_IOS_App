
import Foundation

public struct Schedule: Codable {
    var days: [TrainDay]
}

enum DayAbbreviations: String, Codable {
    case mondey     = "Пн"
    case tuesday    = "Вт"
    case wednesday  = "Ср"
    case thursday   = "Чт"
    case friday     = "Пт"
    case saturday   = "Сб"
    case sunday     = "Вс"
}

public struct TrainDay: Codable {
    var day: DayAbbreviations
    var description: String
}
