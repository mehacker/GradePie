//
//  betterPieChartView.swift
//  GradePie
//
//  Created by Nathan Nguyen on 12/7/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import Charts
import CoreGraphics

class betterPieChartView : PieChartView {
    
    open override func draw (_ rect: CGRect) {
        super.draw(rect)
        
        
        let optionalContext = UIGraphicsGetCurrentContext()
        guard let anContext = optionalContext else { return }
        
        anContext.saveGState()
        
        //        let alpha = animator.phaseX * animator.phaseY
        //        let secondHoleRadius = radius * chart.transparentCircleRadiusPercent
        //
                // make transparent
                anContext.setAlpha(CGFloat(1.0))
                anContext.setFillColor(UIColor.black.cgColor)
        
                // draw the transparent-circle
                anContext.beginPath()
                anContext.addEllipse(in: CGRect(
                    x: center.x - 10,
                    y: center.y - 10,
                    width: 20000,
                    height: 20000))
                anContext.addEllipse(in: CGRect(
                    x: center.x - 5,
                    y: center.y - 5,
                    width: 100000,
                    height: 10000))
                anContext.fillPath()
        
              anContext.restoreGState()
        
        
    }
    
    
}
