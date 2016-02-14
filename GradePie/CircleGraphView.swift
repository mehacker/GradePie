//
//  CircleGraphView.swift
//  GradePie
//
//  Created by Nathan Nguyen on 12/15/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit

class CircleGraphView: UIView {

    var endArc:CGFloat = 0.0{   // in range of 0.0 to 1.0
        didSet{
            setNeedsDisplay()
        }
    }
    
    var endArc2:CGFloat = 0.0{   // in range of 0.0 to 1.0
        didSet {
            setNeedsDisplay()
        }
    }
    
    var endArc3:CGFloat = 0.0{   // in range of 0.0 to 1.0
        didSet{
            setNeedsDisplay()
        }
    }
    
    var arcWidth:CGFloat = 100.0
    var arcColor  = UIColor.yellowColor()
    var arcColor2 = UIColor.redColor()
    var arcColor3 = UIColor.whiteColor()
    var arcBackgroundColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        let fullCircle = 2.0 * CGFloat(M_PI)
        let start:CGFloat = -0.25 * fullCircle
        
        let end:CGFloat = endArc * fullCircle + start
        
        let end2:CGFloat = endArc2 * fullCircle + start
        
        let end3:CGFloat = endArc3 * fullCircle + start
        
        var centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))

        
        var radius:CGFloat = 0.0
        if CGRectGetWidth(rect) > CGRectGetHeight(rect){
            radius = (CGRectGetWidth(rect) - arcWidth) / 2.0
        } else {
            radius = (CGRectGetHeight(rect) - arcWidth) / 2.0
            
            //first arc
            
            let context = UIGraphicsGetCurrentContext()
            
            let colorspace = CGColorSpaceCreateDeviceRGB()
            
            CGContextSetLineWidth(context, arcWidth)
            //CGContextSetLineCap(context, kCGLineCapRound)
            CGContextSetStrokeColorWithColor(context, arcColor.CGColor)
            
            CGContextSetFillColorWithColor(context, arcColor3.CGColor)
            
            CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, start, end, 0)
            
            CGContextStrokePath(context)
            
            //second arc
            
            let context2 = UIGraphicsGetCurrentContext()
            
            
            CGContextSetStrokeColorWithColor(context2, arcColor2.CGColor)
            
            CGContextAddArc(context2, centerPoint.x, centerPoint.y, radius, π / 3, end2, 0)
            
            CGContextStrokePath(context2)
            
            let context3 = UIGraphicsGetCurrentContext()
            
            CGContextSetStrokeColorWithColor(context3, UIColor.greenColor().CGColor)
            
            CGContextAddArc(context3, centerPoint.x, centerPoint.y, radius, π / 6, end3, 0)
            
            CGContextStrokePath(context3)
       

        }
    }
    
    
}
