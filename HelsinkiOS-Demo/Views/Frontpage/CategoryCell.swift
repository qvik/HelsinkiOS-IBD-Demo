//
//  CategoryCell.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var parallaxPos : CGFloat = 0
    
    var category: String? {
        didSet {
            if category != nil {
                titleLabel.text = category!.uppercaseString
                if category == "Finance" {
                    titleLabel.textColor = UIColor.appBlack()
                } else {
                    titleLabel.textColor = UIColor.whiteColor()
                }
                backgroundImageView.image = UIImage(named: "Thumbnail_channel_\(category!)")
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var cellImageFrame = backgroundImageView.frame
        cellImageFrame.origin.y = parallaxPos
        backgroundImageView.frame = cellImageFrame
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        backgroundImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
    }
}

