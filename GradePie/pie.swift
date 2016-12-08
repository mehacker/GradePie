//
//  pie.swift
//  GradePie
//
//  Created by Nathan Nguyen on 10/24/15.
//  Copyright © 2015 Nathan Nguyen. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

@IBDesignable

class pie: UIView {
    
        @IBInspectable var counter: Int = 5
        @IBInspectable var outlineColor : UIColor = UIColor.blue
        @IBInspectable var counterColor: UIColor = UIColor.orange
        
        override func draw(_ rect: CGRect) {
            
            // 1
            let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
            
            // 2
            let radius: CGFloat = max(bounds.width, bounds.height)
            
            // 3
            let arcWidth: CGFloat = 120
            
            // 4
            let startAngle: CGFloat = π / 2
            let endAngle: CGFloat = π / 3
            
            let endAngle2: CGFloat = 2 * π / 3
            
            // 5
            let path = UIBezierPath(arcCenter: center,
                radius: radius/2 - arcWidth/2,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true)
            
            let path2 = UIBezierPath(arcCenter: center,
                radius: radius/2 - arcWidth/2,
                startAngle: startAngle,
                endAngle: endAngle2,
                clockwise: true)
            
            // 6
            path.lineWidth = arcWidth
            counterColor.setStroke()
            path.stroke()
            
            path2.lineWidth = arcWidth
            counterColor.setStroke()
            path.stroke()
            
            //Draw the outline
            
            //1 - first calculate the difference between the two angles
            //ensuring it is positive
            let angleDifference: CGFloat = 2 * π - startAngle + endAngle
            
            let angleDifference2: CGFloat = 2 * π - startAngle + endAngle2
            
            //then calculate the arc for each single glass
            let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
            
            let arcLengthPerGlass2 = angleDifference2 / CGFloat(NoOfGlasses)
            
            //then multiply out by the actual glasses drunk
            let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
            
            let outlineEndAngle2 = arcLengthPerGlass2 * CGFloat(counter) + startAngle
            
            //2 - draw the outer arc
            let outlinePath = UIBezierPath(arcCenter: center,
                radius: bounds.width/2 - 2.5,
                startAngle: startAngle,
                endAngle: outlineEndAngle,
                clockwise: true)
            
            let outlinePath2 = UIBezierPath(arcCenter: center,
                radius: bounds.width/2 - 2.5,
                startAngle: startAngle,
                endAngle: outlineEndAngle2,
                clockwise: true)
            
            //3 - draw the inner arc
            outlinePath.addArc(withCenter: center,
                radius: bounds.width/2 - arcWidth + 2.5,
                startAngle: outlineEndAngle,
                endAngle: startAngle,
                clockwise: false)
            
            outlinePath2.addArc(withCenter: center,
                radius: bounds.width/2 - arcWidth + 2.5,
                startAngle: outlineEndAngle2,
                endAngle: startAngle,
                clockwise: false)
            
            //4 - close the path
            outlinePath.close()
            
            outlineColor.setStroke()
            outlinePath.lineWidth = 5.0
            outlinePath.stroke()
            
            
            //4 - close the path
            outlinePath2.close()
            
            UIColor.blue.setStroke()
            outlinePath2.lineWidth = 5.0
            outlinePath2.stroke()
        
    }
}
