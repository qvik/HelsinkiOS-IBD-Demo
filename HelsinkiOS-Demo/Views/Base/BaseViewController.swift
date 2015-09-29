//
//  BaseViewController.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var appNavBar: BaseNavigationView?
    
    // MARK: Private methods
    
    private func prepareNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        appNavBar?.alpha = 1.0
        
        if let view = appNavBar {
            if let backButton = view.backButton {
                backButton.addTarget(self, action: "backTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        navigationBarAttached()
    }
    
    // MARK: Default action handlers
    
    func backTapped(sender: AnyObject?) {
        if self.navigationController != nil {
            self.navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // MARK: Overridable methods
    
    func navigationBarAttached() {
    }
    
    func navigationBarWillAppear(animated: Bool) {
    }
    
    func navigationBarWillDisappear(animated: Bool) {
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if appNavBar != nil {
            self.prepareNavigationBar()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if appNavBar != nil {
            navigationBarWillAppear(animated)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if appNavBar != nil {
            navigationBarWillDisappear(animated)
        }
    }
    
    
}
