//
//  StandartButton.swift
//  CISApp
//
//  Created by Александр Воробей on 23.10.2022.
//

import Foundation
import UIKit

final class StandartButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    private func setup() {
        let hInset: CGFloat = 25
        let vInset: CGFloat = 14
        
        contentEdgeInsets = UIEdgeInsets(top: vInset, left: hInset,
                                         bottom: vInset, right: hInset)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = UIColor.appColor(.bgColor)
        setTitleColor(UIColor.appColor(.whiteFontColor), for: .normal)
    }

}

//extension UIButton {
//    static public func makeStandartButton(title: String) -> UIButton {
//        var configuration = UIButton.Configuration.filled()
//        configuration.title = title
//
//        let hInset: CGFloat = 25
//        let vInset: CGFloat = 14
//
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: vInset, leading: hInset,
//                                                               bottom: vInset, trailing: hInset)
//        configuration.cornerStyle = .dynamic
//        configuration.background.cornerRadius = 10
//        configuration.baseBackgroundColor = UIColor.appColor(.bgColor)
//        configuration.baseForegroundColor = UIColor.appColor(.whiteFontColor)
//
//        return UIButton(configuration: configuration)
//    }
//
//    static public func makeStandartButton(title: String, width: CGFloat) -> UIButton {
//        var configuration = UIButton.Configuration.filled()
//        configuration.title = title
//        let hInset: CGFloat = 25
//        let vInset: CGFloat = 14
//
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: vInset, leading: hInset,
//                                                               bottom: vInset, trailing: hInset)
//        configuration.cornerStyle = .dynamic
//        configuration.background.cornerRadius = 10
//        configuration.baseBackgroundColor = UIColor.appColor(.bgColor)
//        configuration.baseForegroundColor = UIColor.appColor(.whiteFontColor)
//
//        return UIButton(configuration: configuration)
//    }
//}
