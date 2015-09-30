//
//  ExampleInspectables.swift
//  HelsinkiOS-Demo
//
//  Created by Jerry Jalava on 30/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

enum ExampleEnum {
    case Value1
    case Value2
}

@IBDesignable class ExampleInspectables: UIView {
    
    @IBInspectable var stringInput:String = "A String"
    @IBInspectable var nsStringInput:NSString = "NSString"
    @IBInspectable var integerInput:Int!
    @IBInspectable var cgFloatInput:CGFloat!
    @IBInspectable var floatingPointInput:Double!
    @IBInspectable var booleanInput:Bool = true
    @IBInspectable var colorPicker:UIColor!
    @IBInspectable var pointInput:CGPoint!
    @IBInspectable var areaInput:CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)
    @IBInspectable var sizeInput:CGSize!
    // This variable isn't in camelCase
    @IBInspectable var badlynamedvariable:String!
    
    @IBInspectable var borderColor:UIColor = UIColor.appPink() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat = 2 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var circleColor: UIColor = UIColor(red: (171.0/255.0), green: (250.0/255), blue: (81.0/255.0), alpha: 1.0)
    @IBInspectable var circleRadius:CGFloat = 150
    
    // items that don't display in IB
    @IBInspectable var enumInput:ExampleEnum = .Value1
    @IBInspectable var layoutConstraint:NSLayoutConstraint!
    @IBInspectable var listValues:[String]!
    @IBInspectable var edgeInsets:UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    @IBInspectable var cgVectorInput:CGVector!
    @IBInspectable var cgTransform:CGAffineTransform! = CGAffineTransformIdentity
    @IBInspectable var nsDate:NSDate!

    // MARK: Lifecycle
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
    
    func setupView() {
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
    
    override func drawRect(rect: CGRect) {
//        self.addCirle(self.circleRadius, capRadius: 20, color: self.circleColor)
    }
    
    // MARK: Private methods
    
    func addCirle(arcRadius: CGFloat, capRadius: CGFloat, color: UIColor) {
        let X = CGRectGetMidX(self.bounds)
        let Y = CGRectGetMidY(self.bounds)
        
        // Bottom Oval
        let pathBottom = UIBezierPath(ovalInRect: CGRectMake((X - (arcRadius/2)), (Y - (arcRadius/2)), arcRadius, arcRadius)).CGPath
        self.addOval(20.0, path: pathBottom, strokeStart: 0, strokeEnd: 0.5, strokeColor: color, fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSizeZero)
        
        // Middle Cap
        let pathMiddle = UIBezierPath(ovalInRect: CGRectMake((X - (capRadius/2)) - (arcRadius/2), (Y - (capRadius/2)), capRadius, capRadius)).CGPath
        self.addOval(0.0, path: pathMiddle, strokeStart: 0, strokeEnd: 1.0, strokeColor: color, fillColor: color, shadowRadius: 5.0, shadowOpacity: 0.5, shadowOffsset: CGSizeZero)
        
        // Top Oval
        let pathTop = UIBezierPath(ovalInRect: CGRectMake((X - (arcRadius/2)), (Y - (arcRadius/2)), arcRadius, arcRadius)).CGPath
        self.addOval(20.0, path: pathTop, strokeStart: 0.5, strokeEnd: 1.0, strokeColor: color, fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSizeZero)
        
    }
    
    func addOval(lineWidth: CGFloat, path: CGPathRef, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) {
        
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.CGColor
        arc.fillColor = fillColor.CGColor
        arc.shadowColor = UIColor.blackColor().CGColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset
        layer.addSublayer(arc)
    }
}
