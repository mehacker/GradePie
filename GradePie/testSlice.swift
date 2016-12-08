//
//  testSlice.swift
//  GradePie
//
//  Created by Nathan Nguyen on 12/12/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit
@IBDesignable

class testSlice: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
     path.stroke()
       
//        let path2 = UIBezierPath()
//        let startPoint = CGPoint(x: 390, y:bounds.height)
//        
//        path2.moveToPoint(CGPoint(x: bounds.width/2, y:bounds.height/2))
//        path2.addLineToPoint(CGPoint(x:bounds.width, y:bounds.height/2))
//        
//        path2.addQuadCurveToPoint(startPoint, controlPoint: CGPoint(x:bounds.width, y:bounds.height))
//        
//        
//        
//        UIColor.greenColor().setFill()
//        path2.fill()
        
//        path2.stroke()
        
        let path3 = UIBezierPath()
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let startAngle : CGFloat = 3 * π / 2
        let endAngle : CGFloat = 5 * π / 3
        
        
        path3.addArc(withCenter: center, radius: 100, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path3.fill()
//        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
//        
//        // 2
//        let radius: CGFloat = max(bounds.width, bounds.height)
//        
//        // 3
//        let arcWidth: CGFloat = 130
//        
//        // 4
//        let startAngle: CGFloat = 3 * π / 2
//        let endAngle: CGFloat = 5 * π / 3
//        
//        // 5
//        let path2 = UIBezierPath(arcCenter: center,
//            radius: 250,
//            startAngle: startAngle,
//            endAngle: endAngle,
//            clockwise: true)
//        
//
//        path2.moveToPoint(center)
//        
//        // 6
//        //path2.lineWidth = arcWidth
//            UIColor.greenColor().setFill()
//                path2.fill()
//
//        path2.closePath()
//        path2.stroke()
   
    }
}
