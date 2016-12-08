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
    var arcColor  = UIColor.yellow
    var arcColor2 = UIColor.red
    var arcColor3 = UIColor.white
    var arcBackgroundColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        let fullCircle = 2.0 * CGFloat(M_PI)
        let start:CGFloat = -0.25 * fullCircle
        
        let end:CGFloat = endArc * fullCircle + start
        
        let end2:CGFloat = endArc2 * fullCircle + start
        
        let end3:CGFloat = endArc3 * fullCircle + start
        
        let centerPoint = CGPointMake(rect.midX, rect.midY)

        
        var radius:CGFloat = 0.0
        if rect.width > rect.height{
            radius = (rect.width - arcWidth) / 2.0
        } else {
            radius = (rect.height - arcWidth) / 2.0
            
            //first arc
            
            let context = UIGraphicsGetCurrentContext()
            
            let colorspace = CGColorSpaceCreateDeviceRGB()
            
            context!.setLineWidth(arcWidth)
            //CGContextSetLineCap(context, kCGLineCapRound)
            context!.setStrokeColor(arcColor.cgColor)
            
            context!.setFillColor(arcColor3.cgColor)
            
            CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, start, end, 0)
            
            context!.strokePath()
            
            //second arc
            
            let context2 = UIGraphicsGetCurrentContext()
            
            
            context2!.setStrokeColor(arcColor2.cgColor)
            
            CGContextAddArc(context2, centerPoint.x, centerPoint.y, radius, π / 3, end2, 0)
            
            context2!.strokePath()
            
            let context3 = UIGraphicsGetCurrentContext()
            
            context3!.setStrokeColor(UIColor.green.cgColor)
            
            CGContextAddArc(context3, centerPoint.x, centerPoint.y, radius, π / 6, end3, 0)
            
            context3!.strokePath()
       

        }
    }
    
    
}
