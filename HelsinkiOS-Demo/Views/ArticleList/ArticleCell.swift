//
//  ArticleCell.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

public class ArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var metaView: ArticleMeta!
    
    public var article: Article? {
        didSet {
            if let article = article {
                titleLabel.text = article.title
                metaView.article = article
                metaView.showCategory = false
            }
        }
    }
    
    // MARK: Lifecycle
    
    override public func prepareForReuse() {
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
}

