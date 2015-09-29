//
//  LogoNavigation.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

public class LogoNavigationView: BaseNavigationView {

    // MARK : Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK : Inspectables
    
    @IBInspectable
    public var fillColor: UIColor = UIColor.appPurple() {
        didSet {
            if let backgroundImage = self.backgroundImage {
                setBackgroundWithColorFill(image: backgroundImage, color: fillColor)
            } else {
                self.backgroundColor = fillColor
            }
        }
    }
    
    @IBInspectable
    public var category: String? {
        didSet {
            let bundle = NSBundle(forClass: self.dynamicType)
            self.backgroundImage = UIImage(named: "Thumbnail_channel_\(category!)", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        }
    }
    
    //@IBInspectable
    public var backgroundImage: UIImage? {
        didSet {
            setBackgroundWithColorFill(image: backgroundImage!, color: self.fillColor)
        }
    }
    
    @IBInspectable
    public var showBackAsClose: Bool = false {
        didSet {
            setupView()
        }
    }
    
    // MARK : Internal methods
    
    func setBackgroundWithColorFill(image image: UIImage, color: UIColor, alpha: CGFloat = 0.26) {
        let heigth = image.size.height // CGFloat(64)
        let size = CGSize(width: frame.size.width, height: heigth)
        
        UIGraphicsBeginImageContext(size)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        color.setFill()
        
        CGContextSetAlpha(context, alpha)
        
        CGContextTranslateCTM(context, 0, size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect: CGRect = CGRectMake(0, 0, size.width, size.height)
        
        CGContextDrawImage(context, rect, image.CGImage)
        
        CGContextClipToMask(context, rect, image.CGImage)
        CGContextAddRect(context, rect)
        CGContextDrawPath(context, CGPathDrawingMode.Fill)
        
        let navBackgroundImage: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        backgroundImageView.frame = CGRectMake(0, 0, frame.size.width, heigth)
        backgroundImageView.image = navBackgroundImage
    }
    
    // MARK: Lifecycle
    
    override func viewInited() {
        setupView()
    }
    
    func setupView() {
        let bundle = NSBundle(forClass: self.dynamicType)
        var iconName = "Icon_navbar_Back"
        if showBackAsClose {
            iconName = "icon_navbar_close"
        }
        let image = UIImage(named: iconName, inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        self.backButton.setImage(image, forState: .Normal)
    }
}
