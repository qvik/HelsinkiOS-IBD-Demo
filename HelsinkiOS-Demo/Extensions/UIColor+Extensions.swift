//
//  UIColor+Extensions.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

extension UIColor {
    static func appPurple() -> UIColor {
        let color = UIColor(red: 161/255, green: 117/255, blue: 211/255, alpha: 1)
        return color
    }
    
    static func appPink() -> UIColor {
        return UIColor(red: 230/255, green: 82/255, blue: 138/255, alpha: 1)
    }
    
    static func appBlack() -> UIColor {
        return UIColor(red: 29/255, green: 29/255, blue: 38/255, alpha: 1)
    }
    
    static func appWhite() -> UIColor {
        return UIColor.whiteColor()
    }
}
