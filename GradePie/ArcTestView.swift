//
//  ArcTestView.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/21/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit
import QuartzCore

class ArcTestView: UIView {
    
    let section1 = section()
    let section2 = section()
    let section3 = section()
    let section4 = section()
    
    var courseSections = [section] ()
    

    //Arrays
    
    // Splits of Pie
    var pieEndPointDegrees = [CGFloat] ()
    var pieEndPointInRadians = [CGFloat] ()
    
    //Percentage of Sections earned
    var percentageOfSectionEarned = [CGFloat] ()
    var percentageOfSectionEarnedInRadians = [CGFloat] ()
    
    //End of Section
    var endOfSectionInDegrees = [CGFloat] ()
    var endOfSectionInRadians = [CGFloat] ()
    
    var cCoordinate : CGFloat = 0.0
    var yCoordinate : CGFloat = 0.0
    
    //Outline
    @IBInspectable var counter: Int = 5
    @IBInspectable var redColor : UIColor = UIColor(red: 255.0/255, green: 185.0/255, blue: 185.0/255, alpha: 1.0)
    @IBInspectable var greenColor: UIColor = UIColor(red: 131.0/255, green: 257.0/255, blue: 162.0/255, alpha: 1.0)
    
    
    override func drawRect(rect: CGRect) {
        
        cCoordinate = CGRectGetWidth(rect) / 2.0
        yCoordinate = CGRectGetHeight(rect) / 2.0
        
        section1.percentageOfCourse = 30
        section2.percentageOfCourse = 60
        section3.percentageOfCourse = 135
        section4.percentageOfCourse = 135
        
        section1.percentageEarned = 0.50
        section2.percentageEarned = 0.50
        section3.percentageEarned = 0.50
        section4.percentageEarned = 0.50
        
        courseSections.append(section1)
        courseSections.append(section2)
        courseSections.append(section3)
        courseSections.append(section4)
        
        pieEndPointDegrees.append(30)
        pieEndPointDegrees.append(90)
        pieEndPointDegrees.append(225)
        pieEndPointDegrees.append(360)
        
        
        print("The split degrees in Pie")
        print(pieEndPointDegrees)
        
        for (var index1 = 0; index1 < pieEndPointDegrees.count; index1++) {
            pieEndPointInRadians.append(degree2radian(CGFloat(pieEndPointDegrees[index1])))
        }
        
        print("The split radians of Pie")
        print(pieEndPointInRadians)
        print("\n")
        
        
        for section in courseSections {
            percentageOfSectionEarned.append(CGFloat(section.percentageEarned * section.percentageOfCourse))
        }
        
        print("percentage of section earned")
        print(percentageOfSectionEarned)
       
        for percentageEarned in percentageOfSectionEarned {
            percentageOfSectionEarnedInRadians.append(degree2radian(percentageEarned))
        }
        
        print("percentage of section earned in radians")
        print(percentageOfSectionEarnedInRadians)
        print("\n")
        
    
        endOfSectionInRadians.append(percentageOfSectionEarnedInRadians[0])
        
        for var index2 = 1; index2 < (pieEndPointDegrees.count); index2++ {
            endOfSectionInDegrees.append(pieEndPointDegrees[index2 - 1] + percentageOfSectionEarned[index2])
        }
        
        print("end of section in degrees")
        print(endOfSectionInDegrees)
        
        
        for var index3 = 0; index3 < endOfSectionInDegrees.count; index3++ {
            endOfSectionInRadians.append(degree2radian(endOfSectionInDegrees[index3]))
        }
  
        print("end of section in radians")
        print(endOfSectionInRadians)
    
            // 1
            let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
            
            // 2
            let radius: CGFloat = max(bounds.width, bounds.height)
            
            // 3
            //  let arcWidth: CGFloat = 285
        
        
            //Outline of slice
            // 4
            let startAngle: CGFloat = 0
            let endAngle: CGFloat = π / 4
            
            // 5
            var path = UIBezierPath(arcCenter: center,
                radius: 101.0,
                startAngle: startAngle,
                endAngle: degree2radian(30),
                clockwise: true)
            
            // 4
//            let startAngle2: CGFloat = π / 4
//            let endAngle2: CGFloat = π / 2
        
            // 5
//            var path2 = UIBezierPath(arcCenter: center,
//                radius: 101.0,
//                startAngle: startAngle2,
//                endAngle: endAngle2,
//                clockwise: true)
        
            // 6
            path.lineWidth = 2
            UIColor.redColor().setStroke()
            path.stroke()
            
            path.addLineToPoint(center)
            
            path.closePath()
            
            path.stroke()
            
//            path2.lineWidth = 2
//            UIColor.greenColor().setStroke()
//            path2.stroke()
//            
//            path2.addLineToPoint(center)
//            
//            path2.closePath()
//            
//            path2.stroke()
        
            for var index = 1; index < pieEndPointInRadians.count; index++ {
                
                let path = UIBezierPath(arcCenter: center,
                    radius: 101.0,
                    startAngle: pieEndPointInRadians[index - 1],
                    endAngle: pieEndPointInRadians[index],
                    clockwise: false)
                
                path.lineWidth = 2
                getRandomColor().setStroke()
                path.stroke()
                
                path.addLineToPoint(center)
                
                path.closePath()
                
                path.stroke()
            }
        
    
        //Draw slices
        let context = UIGraphicsGetCurrentContext()
        
        createSlice (0.0, endAngle: percentageOfSectionEarnedInRadians[0],currentContext: context!, color: redColor)
       
        createSlice (pieEndPointInRadians[0], endAngle: endOfSectionInRadians[1],currentContext: context!, color: redColor)
        
        createSlice (pieEndPointInRadians[1], endAngle: endOfSectionInRadians[2],currentContext: context!, color: redColor)
        
        createSlice (pieEndPointInRadians[2], endAngle: endOfSectionInRadians[3],currentContext: context!, color: redColor)
        
//        for (var index = 1; index < courseSections.count; index++) {
//            createSlice(pieEndPointInRadians[0] - 1, endAngle: endOfSectionInRadians[index], currentContext: context!
//                , color: redColor)
//        }
        
        CGContextSetLineWidth(context, 100)
        
    }
    
    //method to turn degrees to radians
    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }
    
    //spit our random colors
     func getRandomColor() -> UIColor{
        
     let randomRed:CGFloat = CGFloat(drand48())
        
     let randomGreen:CGFloat = CGFloat(drand48())
        
     let randomBlue:CGFloat = CGFloat(drand48())
        
     return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    func createSlice (startAngle: CGFloat, endAngle :CGFloat, currentContext: CGContext, color : UIColor) {
        
        CGContextSetLineWidth(currentContext, 100)
        
        CGContextSetStrokeColorWithColor(currentContext, color.CGColor)
        
        CGContextAddArc(currentContext, cCoordinate, yCoordinate, 50.0, startAngle, endAngle, 0)
        
        CGContextStrokePath(currentContext)
    }
}
