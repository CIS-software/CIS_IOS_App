import UIKit

protocol AuthCardsCoordinatorProtocol {
    func toLoginCard() 
    
    func toRegisterCard()
    
    func toMainCard()
    
    func toPersonalDataInput()
    
    func toMainFlow()
    
    func showLoadingVC()
    
    func hideLoadingVC()
}
