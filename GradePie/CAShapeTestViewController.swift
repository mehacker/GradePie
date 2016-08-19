//
//  CAShapeTestViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 2/3/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

import Charts

//class CAShapeTestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
class CAShapeTestViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var courseName: UILabel!
   // @IBOutlet weak var sectionsList: UITableView!
    @IBOutlet weak var gradeSlider: UISlider!
    @IBOutlet weak var gradeToAdd: UILabel!


    @IBOutlet weak var pieChartView: PieChartView!
   // @IBOutlet weak var pieGraphView: UIView!
    
    @IBOutlet weak var overallGrade: UILabel!
    
    let progressIndicatorView = chartSlice(frame: CGRectZero)
    
    var courseSections = [section]()
    var aCourse  = course()
    var slices = [CALayer]()
    
    var testGrade = sliceLayer()
    
    var slicePath3 = UIBezierPath ()
    
    var currentStudent = student ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // overallGrade.layer.cornerRadius = overallGrade.frame.height/2
        //overallGrade.clipsToBounds = true
        
       // self.pieGraphView.layer.borderColor = UIColor.redColor().CGColor
        
       // self.pieGraphView.userInteractionEnabled = true
        
    //    self.sectionsList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "aSection")

     //   courseName.text = aCourse.name
        
//        createPieGraph(courseSections)
     //   pieChartView.delegate = self
        
        var sectionNames: Array<String> = []
        var grades: Array<Double> = []
        
        for section in courseSections {
            sectionNames.append(section.name)
            grades.append(Double(section.percentageOfCourse))
            
        }
        
        let gradesPercentagedEarned = addPercentageEarned(courseSections)
        
        print(gradesPercentagedEarned)
        
        setChart(gradesPercentagedEarned)
    
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.aCourse.sections.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell:UITableViewCell = self.sectionsList.dequeueReusableCellWithIdentifier("aSection")! as UITableViewCell
//        
//        cell.textLabel?.text = self.aCourse.sections[indexPath.row].name
//        
//        return cell
//    }
    
    // MARK: - CAShapeLayer
    
    func createSlice (startAngle: CGFloat, endAngle: CGFloat, fill: Bool, color: UIColor, opacity: Float) {
        let newSlice = CAShapeLayer()
        
        //var center = CGPointMake((self.view.frame.width/2), (self.view.frame.height/2))
        var center = self.view.center
        
        var radius = 200
        
        if (fill == true) {
            
            var slicePath2 = UIBezierPath ()
            
            slicePath2.addArcWithCenter(center, radius: CGFloat(radius), startAngle: startAngle, endAngle: endAngle, clockwise:true)
            
            slicePath2.addLineToPoint(center)
            
            slicePath2.closePath()
            
            
            //newSlice.path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: endAngle, clockwise:true).CGPath
            
            newSlice.path = slicePath2.CGPath
            
            //newSlice.lineWidth = 200
        }
            
        else {
            newSlice.path = UIBezierPath(arcCenter: center, radius: CGFloat(100), startAngle: startAngle, endAngle: endAngle, clockwise:true).CGPath
            newSlice.lineWidth = 1
            
        }
        
        newSlice.frame = self.view.layer.bounds
        newSlice.position = self.view.center

        
        // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction

        
        // Configure the circle
        newSlice.fillColor = color.CGColor
        //newSlice.fillColor = UIColor.whiteColor().CGColor
        newSlice.opacity = opacity
        newSlice.strokeColor = color.CGColor

        
        // When it gets to the end of its animation, leave it at 0% stroke filled
        newSlice.strokeEnd = 0.0
        
        //newSlice.frame = self.pieGraphView.layer.bounds
        
        //add slice to array 
        slices.append(newSlice)
        
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
        
        
        let fillAnimation = CABasicAnimation(keyPath: "fillColor")
        fillAnimation.repeatCount = 1.0
        fillAnimation.fromValue = UIColor.whiteColor().CGColor
        fillAnimation.toValue = color.CGColor
        fillAnimation.duration = 5.0
      
        fillAnimation.fillMode = kCAFillModeBoth
        fillAnimation.removedOnCompletion = false
    
        fillAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Add the animation to the circle
        newSlice.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        newSlice.addAnimation(fillAnimation, forKey: fillAnimation.keyPath)
    }

    func createPieGraph (courseSections: [section]) {
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
        
        var someColor = getRandomColor()
     
        createSlice(0.0, endAngle: endOfSectionInRadians[0], fill: true, color: someColor, opacity: 1.0)
        createSlice(endOfSectionInRadians[0], endAngle: pieEndPointInRadians[0], fill: true, color: someColor,opacity: 0.1)
        
        for (var a = 1; a < courseSections.count; a++) {
            someColor = getRandomColor()
            createSlice(endOfSectionInRadians[a], endAngle: pieEndPointInRadians[a], fill: true, color: someColor, opacity:  0.1)
            createSlice(pieEndPointInRadians[a-1], endAngle: endOfSectionInRadians[a], fill: true, color: someColor, opacity: 1.0)
     
        }
    
        
    }
    
    //method to turn degrees to radians
    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }

    
    func getRandomColor() -> UIColor {
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }

//    @IBAction func addSimulationSlice(sender: AnyObject) {
       
//        var center = CGPointMake((self.view.frame.width/2), (self.view.frame.height/2))
//        center.x = 240.0
//        center.y = 350.0
//        var radius = 200
//        
//        slicePath3.addArcWithCenter(center, radius: CGFloat(radius), startAngle: degree2radian(270) , endAngle: degree2radian(testGrade.endArc), clockwise:true)
//            
//        slicePath3.addLineToPoint(center)
//            
//        slicePath3.closePath()
//            
//        //newSlice.path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: endAngle, clockwise:true).CGPath
//            
//        testGrade.path = slicePath3.CGPath
//            
//        //newSlice.lineWidth = 200
//        
//        // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
//        
//        
//        // Configure the circle
//        testGrade.backgroundColor = UIColor.blueColor().CGColor
//        testGrade.strokeColor = UIColor.orangeColor().CGColor
//
//        
//        // Add the circle to the parent layer
//        self.pieGraphView.layer.addSublayer(testGrade)
    
//    }
    
    @IBAction func gradeAdder(sender: UISlider) {
        var grade = sender.value
        print(grade)
        gradeToAdd.text = String(grade)
    }

//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesBegan(touches, withEvent: event)
//        var position = CGPoint(x: 0.0, y: 0.0)
//        
//        if let touch = touches.first {
//            position = touch.locationInView(view)
//        }
//        print(self.view.layer.sublayers?.count)
//        
//        var count = 0
//        
//        for layer in self.view.layer.sublayers! {
//  
//            if (layer.containsPoint(position)) {
//            let layerGrabbed = layer.modelLayer() as! CAShapeLayer
//
//            print(layer.position)
//              
//            
//                if count == 5 {
//                        layerGrabbed.fillColor = UIColor.redColor().CGColor
//                }
//                  count += 1
//            }
//            else {
//                print("failed")
//            }
//        }
//    }
    
    // MARK: - Charts Framework
    
    //func setChart(dataPoints: [String], values: [Double]) {
    func setChart(values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Class sections")
        
        
  //let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<values.count {
            let red = Double (arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            
            if (i%2 == 0 ) {
                colors.append(color)
                colors.append(color.colorWithAlphaComponent(0.8))
            }
            
            pieChartDataSet.colors = colors
            
        }
        
               pieChartView.centerText = "Overall Grade"
    }
    
    func addPercentageEarned (sections:  [section]) -> [Double] {
        var values = [Double]()
        for section in sections {
            let fraction = Double(section.percentageOfCourse)*Double(section.percentageEarned)
            values.append(fraction)
            values.append(Double(section.percentageOfCourse) - fraction)
        }
        return values
    }
    
//    func chartValueSelected (charView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight ) {
    func chartValueSelected (charView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int) {
        var sectionGrabbed = section()
        sectionGrabbed = entry.data as! section
      //  print(entry.value, sectionGrabbed.name)
        
        print(self.pieChartView.absoluteAngles)
        print(self.pieChartView.drawAngles)
        self.pieChartView.setNeedsDisplay()
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
