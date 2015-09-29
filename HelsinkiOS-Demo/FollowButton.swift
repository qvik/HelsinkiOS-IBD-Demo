//
//  FollowButton.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

@IBDesignable
class FollowButton: UIButton {
    
    @IBInspectable
    var fillColor: UIColor = UIColor.appPink() {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable
    var following: Bool = false {
        didSet {
            setupView()
        }
    }
    
    // MARK: Lifecycle
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
    
    private func setupView() {
        backgroundColor = fillColor
        tintColor = fillColor
        layer.cornerRadius = 15

        if let titleLabel = self.titleLabel {
            titleLabel.text = following == true ? "Following" : "Follow"
            titleLabel.font = UIFont.appDescription()
            titleLabel.textColor = UIColor.appWhite()
        }
        
        setTitle((following == true ? "Following" : "Follow"), forState: .Normal)
        setTitleColor(UIColor.appWhite(), forState: .Normal)
    }
}