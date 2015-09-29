//
//  UIFont+Extensions.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

extension UIFont {
    static func hnRegular(size size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: size)
    }
    static func hnBold(size size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-Bold", size: size)
    }
    static func appTitleThumbnail() -> UIFont? {
        return UIFont.hnRegular(size: 12)
    }
    static func appTitleChannel() -> UIFont? {
        return UIFont.hnBold(size: 20)
    }
    static func appTitleCategory() -> UIFont? {
        return UIFont.hnBold(size: 12)
    }
    static func appBody() -> UIFont? {
        return UIFont.hnRegular(size: 14)
    }
    static func appBodyBold() -> UIFont? {
        return UIFont.hnBold(size: 14)
    }
    static func appDescription() -> UIFont? {
        return UIFont.hnRegular(size: 12)
    }
}
