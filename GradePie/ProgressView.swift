//
//  ProgressView.swift
//  GradePie
//
//  Created by Nathan Nguyen on 2/21/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

class ProgressView: UIView {

        private func calculateEndAngle(percentage: Double) -> CGFloat {
        let degrees = (percentage / 100) * 360.0
        let startAngle = (-0.5 * M_PI)
        let radians = startAngle + (degrees * (M_PI / 180))
        return CGFloat(radians)
    }
    
    private func getLayer(percentage: Double) -> PieSliceLayer
    {
        
        let startAngle = (-0.5 * M_PI)
        let psl = PieSliceLayer(layer: layer)
        psl.frame = CGRect(x:0, y:0, width:bounds.size.width, height:bounds.size.height)
        psl.startAngle = CGFloat(startAngle)
        return psl
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            DispatchTime.now(
//                dispatch_time_t(DispatchTime.now()),
                  dispatch_time_t()
//                Int64(delay * Double(NSEC_PER_SEC))
            ),
            DispatchQueue.main, closure)
    }
    
    private func draw(){
//        let psl = getLayer(0.0)
//        layer.addSublayer(psl)
//        
//        delay (0.1) {
//         psl.endAngle = self.calculateEndAngle(10.0)
//        }
        let psl1 = getLayer(percentage: 0.0)
        layer.addSublayer(psl1)
        delay(delay: 0.8) {
            psl1.startAngle = 0
            psl1.endAngle = 0.60
        }
        
        let psl2 = getLayer(percentage: 0.0)
        layer.addSublayer(psl2)
        delay(delay: 0.8) {
            psl2.startAngle = 0.60
            psl2.endAngle = 0.90
        }
        
//        delay(1.8) {
//            psl.endAngle = self.calculateEndAngle(50.0)
//        }
//        delay(2.6) {
//            psl.endAngle = self.calculateEndAngle(70.0)
//        }
//        delay(3.2) {
//            psl.endAngle = self.calculateEndAngle(100.0)
//        }
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
       // draw()
        
        var circle = CAShapeLayer()
        
    }

}
