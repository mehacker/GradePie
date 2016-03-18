//
//  PieSliceLayer.swift
//  GradePie
//
//  Created by Nathan Nguyen on 2/21/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

class PieSliceLayer: CAShapeLayer {
    
    var startAngle = CGFloat(-0.5 * M_PI)
    @NSManaged var endAngle: CGFloat
    var maxAngle = CGFloat(1.5 * M_PI)
    
    var center: CGPoint {
        return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
    }
    var radius: CGFloat {
        return min(center.x - circleOffset, center.y - circleOffset)
    }
    
    var startPoint: CGPoint {
        let startPointX = Float(center.x) + Float(radius) * cosf(Float(startAngle))
        let startPointY = Float(center.y) + Float(radius) * sinf(Float(startAngle))
        return CGPointMake(CGFloat(startPointX), CGFloat(startPointY))
    }
    
    var cw:Int32  {
        return (startAngle > endAngle) ? 1 : 0
    }
    
    
    private var circleOffset:CGFloat = 30.0
    
    func makeAnimationForKey(key: String!) -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: key)
        anim.fromValue = self.presentationLayer()?.valueForKey(key)
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anim.duration = 0.5
        return anim
    }
    
    override func actionForKey(event: String) -> CAAction? {
        if event == "endAngle" {
            return makeAnimationForKey(event)
        }
        return super.actionForKey(event)
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        
        if (layer.isKindOfClass(PieSliceLayer)) {
            if let other = layer as? PieSliceLayer {
                startAngle = other.startAngle
                endAngle = other.endAngle
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func needsDisplayForKey(key: String) -> Bool {
        if (key == "endAngle") {
            return true
        }
        return super.needsDisplayForKey(key)
    }
    
    override func drawInContext(ctx: CGContext) {
            let backgroundRect = CGRectMake(0,0,bounds.size.width,bounds.size.height)
            //CGContextSetBlendMode(ctx, CGBlendMode.DestinationOver)
            CGContextAddRect(ctx, backgroundRect)
            CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
            CGContextFillPath(ctx)
            
            CGContextBeginPath(ctx)
            CGContextMoveToPoint(ctx, center.x, center.y)
            CGContextAddLineToPoint(ctx, startPoint.x, startPoint.y)
            CGContextAddArc(ctx, center.x, center.y, radius, startAngle, endAngle, cw)
            CGContextClosePath(ctx)
            
            CGContextSetFillColorWithColor(ctx, getRandomColor().CGColor)
            CGContextSetLineCap(ctx, CGLineCap.Round)
            
            //CGContextSetBlendMode(ctx, CGBlendMode.DestinationOut)
            CGContextDrawPath(ctx, CGPathDrawingMode.Fill)
    }
    
    //Get Random Color
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }


}
