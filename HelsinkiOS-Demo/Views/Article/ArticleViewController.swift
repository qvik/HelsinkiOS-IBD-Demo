//
//  ArticleViewController.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 29/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

class ArticleViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var metaView: ArticleMeta!
    
    var article: Article?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = article {
            titleLabel.text = article.title
            metaView.article = article
        }
    }
}
