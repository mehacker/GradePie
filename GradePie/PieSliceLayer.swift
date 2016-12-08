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
        return CGPoint(self.bounds.size.width/2, self.bounds.size.height/2)
    }
    var radius: CGFloat {
        return min(center.x - circleOffset, center.y - circleOffset)
    }
    
    var startPoint: CGPoint {
        let startPointX = Float(center.x) + Float(radius) * cosf(Float(startAngle))
        let startPointY = Float(center.y) + Float(radius) * sinf(Float(startAngle))
        return CGPoint(CGFloat(startPointX), CGFloat(startPointY))
    }
    
    var cw:Int32  {
        return (startAngle > endAngle) ? 1 : 0
    }
    
    
    private var circleOffset:CGFloat = 30.0
    
    func makeAnimationForKey(key: String!) -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: key)
        anim.fromValue = self.presentation()?.value(forKey: key)
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anim.duration = 0.5
        return anim
    }
    
    override func action(forKey event: String) -> CAAction? {
        if event == "endAngle" {
            return makeAnimationForKey(key: event)
        }
        return super.action(forKey: event)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        if ((layer as AnyObject).isKind(PieSliceLayer)) {
            if let other = layer as? PieSliceLayer {
                startAngle = other.startAngle
                endAngle = other.endAngle
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if (key == "endAngle") {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func draw(in ctx: CGContext) {
            let backgroundRect = CGRectMake(0,0,bounds.size.width,bounds.size.height)
            //CGContextSetBlendMode(ctx, CGBlendMode.DestinationOver)
            ctx.addRect(backgroundRect)
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.fillPath()
            
            ctx.beginPath()
            CGContextMoveToPoint(ctx, center.x, center.y)
            CGContextAddLineToPoint(ctx, startPoint.x, startPoint.y)
            CGContextAddArc(ctx, center.x, center.y, radius, startAngle, endAngle, cw)
            ctx.closePath()
            
            ctx.setFillColor(getRandomColor().cgColor)
            ctx.setLineCap(CGLineCap.round)
            
            //CGContextSetBlendMode(ctx, CGBlendMode.DestinationOut)
            ctx.drawPath(using: CGPathDrawingMode.fill)
    }
    
    //Get Random Color
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }


}
