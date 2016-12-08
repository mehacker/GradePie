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
    
    
    override func draw(_ rect: CGRect) {
        
        cCoordinate = rect.width / 2.0
        yCoordinate = rect.height / 2.0
        
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
        
        for index1 in 0 ..< pieEndPointDegrees.count {
            pieEndPointInRadians.append(degree2radian(a: CGFloat(pieEndPointDegrees[index1])))
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
            percentageOfSectionEarnedInRadians.append(degree2radian(a: percentageEarned))
        }
        
        print("percentage of section earned in radians")
        print(percentageOfSectionEarnedInRadians)
        print("\n")
        
    
        endOfSectionInRadians.append(percentageOfSectionEarnedInRadians[0])
        
        for index2 in 1 ..< (pieEndPointDegrees.count) {
            endOfSectionInDegrees.append(pieEndPointDegrees[index2 - 1] + percentageOfSectionEarned[index2])
        }
        
        print("end of section in degrees")
        print(endOfSectionInDegrees)
        
        
        for index3 in 0 ..< endOfSectionInDegrees.count {
            endOfSectionInRadians.append(degree2radian(a: endOfSectionInDegrees[index3]))
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
            let path = UIBezierPath(arcCenter: center,
                radius: 101.0,
                startAngle: startAngle,
                endAngle: degree2radian(a: 30),
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
            UIColor.red.setStroke()
            path.stroke()
            
            path.addLine(to: center)
            
            path.close()
            
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
        
            for index in 1 ..< pieEndPointInRadians.count {
                
                let path = UIBezierPath(arcCenter: center,
                    radius: 101.0,
                    startAngle: pieEndPointInRadians[index - 1],
                    endAngle: pieEndPointInRadians[index],
                    clockwise: false)
                
                path.lineWidth = 2
                getRandomColor().setStroke()
                path.stroke()
                
                path.addLine(to: center)
                
                path.close()
                
                path.stroke()
            }
        
        //Draw slices
        let context = UIGraphicsGetCurrentContext()
        
        createSlice (startAngle: 0.0, endAngle: percentageOfSectionEarnedInRadians[0],currentContext: context!, color: redColor)
       
        createSlice (startAngle: pieEndPointInRadians[0], endAngle: endOfSectionInRadians[1],currentContext: context!, color: redColor)
        
        createSlice (startAngle: pieEndPointInRadians[1], endAngle: endOfSectionInRadians[2],currentContext: context!, color: redColor)
        
        createSlice (startAngle: pieEndPointInRadians[2], endAngle: endOfSectionInRadians[3],currentContext: context!, color: redColor)
        
//        for (var index = 1; index < courseSections.count; index++) {
//            createSlice(pieEndPointInRadians[0] - 1, endAngle: endOfSectionInRadians[index], currentContext: context!
//                , color: redColor)
//        }
        
        context!.setLineWidth(100)
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
        
        currentContext.setLineWidth(100)
        
        currentContext.setStrokeColor(color.cgColor)
//        
//        CGContextAddArc(currentContext, cCoordinate, yCoordinate, 50.0, startAngle, endAngle, 0)
        let aPoint = CGPoint(x: cCoordinate, y: yCoordinate)
        currentContext.addArc(center: aPoint, radius: 50.0, startAngle: startAngle, endAngle: 0, clockwise: true)
        currentContext.strokePath()
    }
}
