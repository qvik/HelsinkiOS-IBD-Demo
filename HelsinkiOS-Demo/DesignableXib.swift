//
//  DesignableXib.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 29/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

class DesignableXib: UIView {
    var view: UIView!
    
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
    
    // MARK: Lifecycle
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXibAndInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXibAndInit()
    }
    
    override func prepareForInterfaceBuilder() {
        self.loadXibAndInit()
    }
    
    func loadXibAndInit() {
        let xibName = getXibName()
        
        view = loadViewFromNib(xibName)
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
        
        initView()
        setupView()
    }
    
    func initView() {
    }
    
    func setupView() {
    }
}
