//
//  ArticleSegue.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

class ArticleListSegue: UIStoryboardSegue {
    override func perform() {
        let sourceViewController: UIViewController = self.sourceViewController as UIViewController
        let destinationViewController: UIViewController = self.destinationViewController as UIViewController
        
        sourceViewController.view.addSubview(destinationViewController.view)
        
        destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }) { (finished) -> Void in
            destinationViewController.view.removeFromSuperview()
            sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
        }
    }
}
