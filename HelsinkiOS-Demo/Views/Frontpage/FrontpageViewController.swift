//
//  FrontpageViewController.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

class FrontPageViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellHeight : CGFloat {
        get {
            return 143
        }
    }
    var parallax : CGFloat {
        get {
            return (view.frame.width / 320) * -30
        }
    }
    
    var topCategories: [String] = [
        "Fashion", "Science", "Auto", "Technology",
        "Entertainment", "Environment", "Finance", "Travel"
    ]
    
    // MARK: Private methods
    
    func setParallaxScrollForCells(cells: [CategoryCell]) {
        let statusBarOffset : CGFloat = 0
        
        let currentPos = collectionView.contentOffset.y
        let bottomPos = currentPos + collectionView.frame.size.height
        let topPos = currentPos + statusBarOffset - cellHeight
        
        for cell in cells {
            let pos = (cell.frame.origin.y - topPos) / (bottomPos - topPos)
            // layoutSubviews will be called after willDisplayCell so we do this this way
            cell.parallaxPos = (1-pos) * parallax
            
            // and this is what we normally want to do
            var cellImageFrame = cell.backgroundImageView.frame
            cellImageFrame.origin.y = cell.parallaxPos
            cell.backgroundImageView.frame = cellImageFrame
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toArticleList" {
            let destinationView: ArticleListViewController = segue.destinationViewController as! ArticleListViewController
            destinationView.category = sender as? String
        }
    }
    
    // MARK: NavigationBar overrides
    
    override func navigationBarWillAppear(animated: Bool) {
        super.navigationBarWillAppear(animated)
    }
    
    override func navigationBarWillDisappear(animated: Bool) {
        super.navigationBarWillDisappear(animated)
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        setParallaxScrollForCells(collectionView.visibleCells() as! [CategoryCell])
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topCategories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
        let category = topCategories[indexPath.item]
        cell.category = category
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        setParallaxScrollForCells([cell as! CategoryCell])
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let category = topCategories[indexPath.item]
        performSegueWithIdentifier("toArticleList", sender: category)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        collectionView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        // This needs to be called last so that the BaseViewController can handle our NavigationBar
        super.viewDidLoad()
    }
}
