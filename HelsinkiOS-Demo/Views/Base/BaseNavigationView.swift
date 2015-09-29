//
//  BaseNavigationView.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 28/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

@IBDesignable
public class BaseNavigationView: UIView {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBInspectable public var showBackButton: Bool = false {
        didSet {
            backButton.hidden = !showBackButton
        }
    }
    
    public var view: UIView!
    
    // MARK: Private methods
    
    private func getXibName() -> String {
        let className = NSStringFromClass(self.dynamicType) as String
        let nameParts = className.characters.split {$0 == "."}.map { String($0) }
        return nameParts[1] as String
    }
    
    private func loadViewFromNib(name: String) -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: name, bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    // MARK: Overridable methods
    
    func viewInited() {
    }
    
    // MARK: Lifecycle
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initView()
    }
    
//    override public func prepareForInterfaceBuilder() {
//        self.initView()
//    }
    
    func initView() {
        let xibName = getXibName()
        
        view = loadViewFromNib(xibName)
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
        
        viewInited()
    }
    
}
