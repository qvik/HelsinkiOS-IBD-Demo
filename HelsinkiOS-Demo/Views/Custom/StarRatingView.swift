//
//  StarRating.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 29/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

/**
* A simple star rating view that shows set value with animation
*/
@IBDesignable class StarRatingView: UIView {
    // MARK: Rating View properties
    
    /**
    Array of empty image views
    */
    private var emptyImageViews: [UIImageView] = []
    
    /**
    Array of full image views
    */
    private var fullImageViews: [UIImageView] = []
    
    /**
    Sets the empty image (e.g. a star outline)
    */
    @IBInspectable var emptyImage: UIImage? {
        didSet {
            // Update empty image views
            for imageView in self.emptyImageViews {
                imageView.image = emptyImage
            }
            self.refresh()
        }
    }
    
    /**
    Sets the full image that is overlayed on top of the empty image.
    Should be same size and shape as the empty image.
    */
    @IBInspectable var fullImage: UIImage? {
        didSet {
            // Update full image views
            for imageView in self.fullImageViews {
                imageView.image = fullImage
            }
            self.refresh()
        }
    }
    
    /**
    Sets the empty and full image view content mode.
    */
    var imageContentMode: UIViewContentMode = UIViewContentMode.ScaleAspectFit
    
    /**
    Minimum rating.
    */
    @IBInspectable var minRating: Int  = 0 {
        didSet {
            // Update current rating if needed
            if self.rating < Float(minRating) {
                self.rating = Float(minRating)
                self.refresh()
            }
        }
    }
    
    /**
    Max rating value.
    */
    @IBInspectable var maxRating: Int = 5 {
        didSet {
            let needsRefresh = maxRating != oldValue
            
            if needsRefresh {
                self.removeImageViews()
                self.initImageViews()
                
                // Relayout and refresh
                self.setNeedsLayout()
                self.refresh()
            }
        }
    }
    
    /**
    Minimum image size.
    */
    @IBInspectable var minImageSize: CGSize = CGSize(
        width: 5.0, height: 5.0
    )
    
    /**
    Set the current rating.
    */
    @IBInspectable var rating: Float = 0 {
        didSet {
            if rating != oldValue {
                self.refresh()
            }
        }
    }
    
    /**
    Ratings change by 0.5. Takes priority over floatRatings property.
    */
    @IBInspectable var halfRatings: Bool = false
    
    @IBInspectable var animated: Bool = true
    
    // MARK: Refresh hides or shows full images
    
    func refresh() {
        let animationDuration = 0.7
        
        for i in 0..<self.fullImageViews.count {
            let imageView = self.fullImageViews[i]
            let scaler: CGFloat = (CGFloat(i) * 1.6) + 2.0
            
            imageView.alpha = 0
            imageView.center.y -= 10
            imageView.frame.size.width = imageView.frame.size.width * scaler
            imageView.frame.size.height = imageView.frame.size.height * scaler
        }
        
        UIView.animateWithDuration(animationDuration, animations: { () in
            for i in 0..<self.fullImageViews.count {
                let imageView = self.fullImageViews[i]
                let scaler: CGFloat = (CGFloat(i) * 1.6) + 2.0
                
                imageView.center.y += 10
                imageView.frame.size.width = imageView.frame.size.width / scaler
                imageView.frame.size.height = imageView.frame.size.height / scaler
                
                if self.rating >= Float(i + 1) {
                    imageView.layer.mask = nil
                    //imageView.hidden = false
                    imageView.alpha = 1
                } else if self.rating > Float(i) && self.rating < Float(i + 1) {
                    // Set mask layer for full image
                    let maskLayer = CALayer()
                    maskLayer.frame = CGRect(
                        x: 0, y: 0,
                        width: CGFloat(self.rating - Float(i)) * imageView.frame.size.width,
                        height: imageView.frame.size.height
                    )
                    maskLayer.backgroundColor = UIColor.blackColor().CGColor
                    imageView.layer.mask = maskLayer
                    //imageView.hidden = false
                    imageView.alpha = 1
                } else {
                    imageView.layer.mask = nil
                    //imageView.hidden = true
                }
            }
        })
    }
    
    // MARK: Layout helper classes
    
    // Calculates the ideal ImageView size in a given CGSize
    func sizeForImage(image: UIImage, inSize size:CGSize) -> CGSize {
        let imageRatio = image.size.width / image.size.height
        let viewRatio = size.width / size.height
        
        if imageRatio < viewRatio {
            let scale = size.height / image.size.height
            let width = scale * image.size.width
            
            return CGSizeMake(width, size.height)
        }
        else {
            let scale = size.width / image.size.width
            let height = scale * image.size.height
            
            return CGSizeMake(size.width, height)
        }
    }
    
    // Override to calculate ImageView frames
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let emptyImage = self.emptyImage {
            let desiredImageWidth = self.frame.size.width /
                CGFloat(self.emptyImageViews.count)
            let maxImageWidth = max(self.minImageSize.width, desiredImageWidth)
            let maxImageHeight = max(
                self.minImageSize.height, self.frame.size.height
            )
            let imageViewSize = self.sizeForImage(emptyImage,
                inSize: CGSize(width: maxImageWidth, height: maxImageHeight))
            let imageXOffset = (self.frame.size.width -
                (imageViewSize.width * CGFloat(self.emptyImageViews.count))) /
                CGFloat(self.emptyImageViews.count - 1)
            
            for i in 0..<self.maxRating {
                let x = i == 0 ? 0 : CGFloat(i) * (imageXOffset +
                    imageViewSize.width)
                let imageFrame = CGRect(x: x, y: 0, width: imageViewSize.width,
                    height: imageViewSize.height)
                
                var imageView = self.emptyImageViews[i]
                imageView.frame = imageFrame
                
                imageView = self.fullImageViews[i]
                imageView.frame = imageFrame
            }
            
            self.refresh()
        }
    }
    
    func removeImageViews() {
        // Remove old image views
        for i in 0..<self.emptyImageViews.count {
            var imageView = self.emptyImageViews[i]
            imageView.removeFromSuperview()
            imageView = self.fullImageViews[i]
            imageView.removeFromSuperview()
        }
        self.emptyImageViews.removeAll(keepCapacity: false)
        self.fullImageViews.removeAll(keepCapacity: false)
    }
    
    func initImageViews() {
        if self.emptyImageViews.count != 0 {
            return
        }
        
        // Add new image views
        for _ in 0..<self.maxRating {
            let emptyImageView = UIImageView()
            emptyImageView.contentMode = self.imageContentMode
            emptyImageView.image = self.emptyImage
            self.emptyImageViews.append(emptyImageView)
            self.addSubview(emptyImageView)
            
            let fullImageView = UIImageView()
            fullImageView.contentMode = self.imageContentMode
            fullImageView.image = self.fullImage
            self.fullImageViews.append(fullImageView)
            self.addSubview(fullImageView)
        }
    }

    // MARK: Lifecycle
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.initImageViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initImageViews()
    }
    
    override func prepareForInterfaceBuilder() {
        self.initImageViews()
    }
}
