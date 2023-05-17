 import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
