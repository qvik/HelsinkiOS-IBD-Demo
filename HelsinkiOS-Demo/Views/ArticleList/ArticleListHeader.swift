//
//  ArticleListHeader.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

@IBDesignable
class ArticleListHeader: DesignableXib {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var followButton: FollowButton!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBInspectable var category: String = "Fashion" {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var following: Bool = false {
        didSet {
            setupView()
        }
    }
    
    // MARK: Default action handlers
    
    func followTapped(sender: AnyObject?) {
        followButton.following = !followButton.following
    }
    
    // MARK: Lifecycle
    
    override func initView() {
        followButton.addTarget(self, action: "followTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func setupView() {
        followButton.following = following

        categoryLabel.text = category.uppercaseString

        let bundle = NSBundle(forClass: self.dynamicType)
        categoryImage.image = UIImage(named: "Thumbnail_channel_\(category)", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)

        categoryLabel.textColor = UIColor.whiteColor()
        categoryLabel.layer.shadowColor = UIColor.appBlack().CGColor
        categoryLabel.layer.shadowRadius = 4.0
        categoryLabel.layer.shadowOpacity = 2.9
        categoryLabel.layer.shadowOffset = CGSizeZero
        categoryLabel.layer.masksToBounds = false
    }
}
