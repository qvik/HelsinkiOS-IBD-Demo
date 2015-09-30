//
//  ArticleListViewController.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

public struct Article {
    var title: String
    var source: String
    var category: String
    var createdAt: String
}

class ArticleListViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: ArticleListHeader!
    
    var category: String?
    var articles = [Article]()
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toArticleDetails" {
            let destinationView: ArticleViewController = segue.destinationViewController as! ArticleViewController
            let article = articles[sender as! Int]
            destinationView.article = article
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleCell
        cell.article = articles[indexPath.item]
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toArticleDetails", sender: indexPath.item)
    }

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(collectionView.frame.width, 100)
    }
    
    // MARK: Article generation
    
    func generateDummyArticles() -> Void {
        if let category = category {
            for index in 1...15 {
                articles.append(Article(title: "In the Prawn Nebula, a Nursery for Newborn stars \(index), lorem ipsum doler im sadet", source: "CNN", category: category, createdAt: "Sep \(index), 2015"))
            }
        }
        collectionView.reloadData()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        collectionView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
        collectionView.backgroundColor = UIColor.clearColor()
        
        generateDummyArticles()
        if let appNavBar = appNavBar as? LogoNavigationView {
            appNavBar.category = category
        }
        headerView.category = category!

        super.viewDidLoad()
    }
}
