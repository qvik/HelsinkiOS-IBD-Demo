//
//  ArticleSegueUnwind.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

class ArticleListUnwindSegue: UIStoryboardSegue {
    override func perform() {
        let sourceViewController: UIViewController = self.sourceViewController as UIViewController
        let destinationViewController: UIViewController = self.destinationViewController as UIViewController
        
        destinationViewController.view.addSubview(sourceViewController.view)
        
        //sourceViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            sourceViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (finished) -> Void in
                sourceViewController.view.removeFromSuperview()
                destinationViewController.presentViewController(sourceViewController, animated: false, completion: nil)
        }
    }
}