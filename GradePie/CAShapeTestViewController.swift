//
//  CAShapeTestViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 2/3/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

class CAShapeTestViewController: UIViewController {
 
    @IBOutlet weak var chartSliceView: UIView!
    
    let progressIndicatorView = chartSlice(frame: CGRectZero)
    var courseSections = [section]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    /////////////Data
        
//        let section1 = section()
//        let section2 = section()
//        let section3 = section()
//        let section4 = section()
//        
//        section1.percentageOfCourse = 30
//        section2.percentageOfCourse = 60
//        section3.percentageOfCourse = 135
//        section4.percentageOfCourse = 135
//        
//        section1.percentageEarned = 0.50
//        section2.percentageEarned = 0.50
//        section3.percentageEarned = 0.50
//        section4.percentageEarned = 0.50
//        
//        courseSections.append(section1)
//        courseSections.append(section2)
//        courseSections.append(section3)
//        courseSections.append(section4)
        
        print(courseSections)
        
        createPieGraph(courseSections)
    }
    
    func createSlice (startAngle: CGFloat, endAngle: CGFloat, fill: Bool) {
        let newSlice = CAShapeLayer()
        
        let center = CGPointMake(200.0, 200.0)
        
        var radius = 50
        
        if (fill == true) {
                    newSlice.path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: endAngle, clockwise:true).CGPath
            newSlice.lineWidth = 100
        }
        else {
            newSlice.path = UIBezierPath(arcCenter: center, radius: CGFloat(100), startAngle: startAngle, endAngle: endAngle, clockwise:true).CGPath
            newSlice.lineWidth = 1
            
        }
        
        // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction

        
        // Configure the circle
        newSlice.fillColor = UIColor.whiteColor().CGColor
        newSlice.strokeColor = getRandomColor().CGColor
        

        
        
        // When it gets to the end of its animation, leave it at 0% stroke filled
        newSlice.strokeEnd = 0.0
        
        // Add the circle to the parent layer
        self.view.layer.addSublayer(newSlice)
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.repeatCount = 1.0
        
        drawAnimation.fromValue = NSNumber(float: 0.0)
        drawAnimation.toValue = NSNumber(double: 1.0)
        
        drawAnimation.duration = 5.0
        
        drawAnimation.fillMode = kCAFillModeForwards
        drawAnimation.removedOnCompletion = false
        
        
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Add the animation to the circle
        newSlice.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        
    }


    func createPieGraph (courseSections: [section]) {
        let radius = 50
        
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
        
        ///////////////////////////////////////////////////////////////////////////////
        
//        pieEndPointDegrees.append(30)
//        pieEndPointDegrees.append(90)
//        pieEndPointDegrees.append(225)
//        pieEndPointDegrees.append(360)
        
 
        
        pieEndPointDegrees.append(CGFloat(courseSections[0].percentageOfCourse))
        var endDegree:CGFloat = CGFloat(courseSections[0].percentageOfCourse)
        for (var index = 1; index < courseSections.count; index++) {
            pieEndPointDegrees.append(CGFloat(courseSections[index].percentageOfCourse) + endDegree)
            endDegree = pieEndPointDegrees[index]
        }
        
        print("The splits in degree of the pie:")
        print(pieEndPointDegrees)
        
        for (var index1 = 0; index1 < pieEndPointDegrees.count; index1++) {
            pieEndPointInRadians.append(degree2radian(CGFloat(pieEndPointDegrees[index1])))
        }
        
        for section in courseSections {
            percentageOfSectionEarned.append(CGFloat(section.percentageEarned * section.percentageOfCourse))
        }
        
        print("percentage of section earned")
        print(percentageOfSectionEarned)
        
        for percentageEarned in percentageOfSectionEarned {
            percentageOfSectionEarnedInRadians.append(degree2radian(percentageEarned))
        }
        
//        print("percentage of section earned in radians")
//        print(percentageOfSectionEarnedInRadians)
//        print("\n")
        
       endOfSectionInDegrees.append(percentageOfSectionEarned[0])
        for (var index2 = 1; index2 < pieEndPointDegrees.count; index2++) {
            endOfSectionInDegrees.append(pieEndPointDegrees[index2-1] + percentageOfSectionEarned[index2])
        }
        
        print("end of section in degrees")
        print(endOfSectionInDegrees)
        
        endOfSectionInRadians.append(percentageOfSectionEarnedInRadians[0])
        for (var index3 = 1; index3 < endOfSectionInDegrees.count; index3++) {
            endOfSectionInRadians.append(degree2radian(endOfSectionInDegrees[index3]))
        }
        
//        print("end of section in radians")
//        print(endOfSectionInRadians)
        
        
//Draw the slices 
        
        createSlice(0.0, endAngle: endOfSectionInRadians[0], fill: true)
        for (var a = 1; a < courseSections.count; a++) {
                createSlice(pieEndPointInRadians[a-1], endAngle: endOfSectionInRadians[a], fill: true)
        }
        
        createSlice(endOfSectionInRadians[0], endAngle: pieEndPointInRadians[0], fill: false)
        for (var a = 1; a < courseSections.count; a++) {
            createSlice(endOfSectionInRadians[a], endAngle: pieEndPointInRadians[a], fill: false)
        }

    }
    
    //method to turn degrees to radians
    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }


    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
