//
//  ArticleMeta.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 29/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

@IBDesignable class ArticleMeta: DesignableXib {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var article: Article? {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var showCategory: Bool = false {
        didSet {
            setupView()
        }
    }
    
    // MARK: Lifecycle
    
    override func setupView() {
        categoryLabel.hidden = !showCategory

        if let article = article {
            sourceLabel.text = article.source
            timeLabel.text = article.createdAt
            categoryLabel.text = article.category.uppercaseString
        }
    }
}
