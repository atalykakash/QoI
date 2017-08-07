//
//  Hints.swift
//  IslamFAQ
//
//  Created by Admin on 7/26/17.
//  Copyright © 2017 Adilkhan Khassanov. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    static let topicCellHeight : CGFloat = 80.0
    static let screenWidth : CGFloat = UIScreen.main.bounds.width
    static let screenHeight : CGFloat = UIScreen.main.bounds.height
}

extension UIFont {
    
    static func risingSunRegular() -> UIFont {
        return UIFont(name: "RisingSun-Regular", size: Constants.screenWidth*0.04)!
    }
    
    static func aliceRegular() -> UIFont {
        return UIFont(name: "Alice-Regular", size: Constants.screenWidth*0.04)!
    }
}
