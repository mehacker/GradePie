//
//  slice.swift
//  GradePie
//
//  Created by Nathan Nguyen on 12/5/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit

@IBDesignable

class slice: UIView {

    @IBInspectable var counter: Int = 5
    @IBInspectable var outlineColor : UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
      //  let arcWidth: CGFloat = 285
        
        // 4
        let startAngle: CGFloat = 3 * π / 2
        let endAngle: CGFloat = 7 * π / 4
        
        // 5
        var path = UIBezierPath(arcCenter: center,
            radius: radius/2 - 285/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        // 4
        let startAngle2: CGFloat = 7 * π / 4
        let endAngle2: CGFloat = 2 * π
        
        // 5
        var path2 = UIBezierPath(arcCenter: center,
            radius: radius/2 - 285/2,
            startAngle: startAngle2,
            endAngle: endAngle2,
            clockwise: true)
    
        // 6
        path.lineWidth = 2
        counterColor.setStroke()
        path.stroke()
        
        path.addLineToPoint(center)
        
        path.closePath()
        
        path.stroke()
        
        path2.lineWidth = 2
        UIColor.blueColor().setStroke()
        path2.stroke()
        
        path2.addLineToPoint(center)
        
        path2.closePath()
        
        path2.stroke()
        
}
}
