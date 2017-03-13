//
//  CAShapeTestViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 2/3/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit
import CoreGraphics
import Foundation
import Charts
import RealmSwift
import CircleMenu

class CAShapeTestViewController: UIViewController, ChartViewDelegate, UITableViewDelegate, UITableViewDataSource, CircleMenuDelegate {
    
    @IBOutlet weak var circleMenu: CircleMenu!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var gradeToAdd: UILabel!
    @IBOutlet weak var gradeSlider: UISlider!
    @IBOutlet weak var gradesLeftTF: UITextField!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var gradesTableView: UITableView!
    @IBOutlet weak var sliceView: slice!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var Answer: UILabel!
    
    let progressIndicatorView = chartSlice(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100)))
//  var courseSections = [section]()
    var aCourse  = course()
    var slices = [CALayer]()
    var testGrade = sliceLayer()
    var slicePath3 = UIBezierPath ()
    var currentStudent = Student ()
    var selectedSection = section ()
    var testSections = [section] ()
    var coursesSections = [section] ()
    var loggedInAccount = Account ()
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(loggedInAccount)
        
//      createPieGraph(courseSections)
        
        gradesTableView.delegate = self
        gradesTableView.dataSource = self
        pieChartView.delegate = self
        circleMenu.delegate = self

        var sectionNames: Array<String> = []
        var grades: Array<Double> = []
        
        //Query database for current course
        grabCourse()
        
        for section in coursesSections {
            sectionNames.append(section.name)
            grades.append(Double(section.percentageOfCourse))

        }
        
        let gradesPercentagedEarned = addPercentageEarned(sections: coursesSections)
        
        aCourse.sections = List<section>(coursesSections)
        aCourse.getOverallGrade()
        pieChartView.centerText = "Current: %" + String(format :"%.0f", aCourse.percentageEarned) + "\n Best: " 
        pieChartView.holeRadiusPercent = 0.30
        pieChartView.transparentCircleRadiusPercent = 0
        
       // addGrade(sectionName: "Tests")
    
//      pieChartView.transparentCircleRadiusPercent = 0.50
        
//      self.pieChartView.rotationEnabled = false
  
        setChart(values: coursesSections, percentagesEarned: gradesPercentagedEarned)
        
        self.gradesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

//      drawSeondLayer(context: context)
        
//      pieChartView.usePercentValuesEnabled = true
        
//        let button = CircleMenu(
//            frame: CGRect(x: 200, y: 200, width: 50, height: 50),
//            normalIcon:"icon_menu",
//            selectedIcon:"icon_close",
//            buttonsCount: 4,
//            duration: 4,
//            distance: 120)
//        button.delegate = self
//        button.layer.cornerRadius = button.frame.size.width / 2.0
//        self.view.addSubview(button)
     
    }
    
    // Realm Query
    func grabCourse () {
        let realm = try! Realm()
        
//        let usernameSearch = realm.objects(Account.self).filter("username = %@ AND password = %a", loggedInAccount.username, loggedInAccount.password)

        let usernameSearch = realm.objects(Account.self).filter("username = %@ AND password = %a", "tester" , "password")
        
        loggedInAccount = usernameSearch[0]
        
        let studentOfAccount: Student = loggedInAccount.student!
        
        let grabbedCourses = studentOfAccount.courses
        
        let grabbedCourse = grabbedCourses[0]
        
        self.courseName.text = grabbedCourse.name
        
        for section in grabbedCourse.sections {
            coursesSections.append(section)
        }

    }
    
    func addGrade (sectionName: String) {
        let realm = try! Realm ()
        
//        let usernameSearch = realm.objects(Account.self).filter("username = %@ AND password = %a", "tester" , "password")
//
//        let studentOfAccount: Student = loggedInAccount.student!
//        
//        let grabbedCourses = studentOfAccount.courses
//        
//        let grabbedCourse = grabbedCourses[0]
//        
//        grabbedCourse.sections
        
//        let section : section = realm.objects(Account.self).filter("section =  %@",sectionName)
//        let newGrade = Grade()
//        newGrade.value = Float(gradesLeftTF.text!)!
//        section.grades.append(newGrade)
//        try! realm.write { }
        
        try! realm.write {
        let sectionSearched = realm.objects(section.self).filter("name = %@", sectionName)

        let sectionFound = sectionSearched[0]
        let grade = Grade()
        grade.value = 80
        sectionFound.addGrade(grade: grade)
        
            realm.add(sectionFound, update: true)
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
    
    // MARK: - Charts Framework
    func setChart(values: [section], percentagesEarned: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0...values.count-1 {
            var sectionGrabbed = section()
            sectionGrabbed = coursesSections[i]
            var value = sectionGrabbed.percentageOfCourse/100
//          var value = sectionGrabbed.percentageOfCourse
            
            //Convert to a percentage of the chart
//            value = (value/100) * 360
            
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(value), data: sectionGrabbed)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Class Sections")
//      pieChartDataSet.xValuePosition = .outsideSlice
        let pieChartData = PieChartData(dataSet: pieChartDataSet)

        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<values.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 0.5)
            
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
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
    
    @IBAction func flipVIew(_ sender: Any) {
        if (isGraphViewShowing) {
            
            //hide Graph
            UIView.transition(from: sliceView,
                              to: pieChartView,
                                      duration: 1.0,
                                      options: UIViewAnimationOptions.transitionFlipFromLeft,
                                      completion:nil)
        } else {
            
            //show Graph
            UIView.transition(from: pieChartView,
                              to: sliceView,
                                      duration: 1.0,
                                      options: UIViewAnimationOptions.transitionFlipFromRight,
//                                        | UIViewAnimationOptions.ShowHideTransitionViews,
                                      completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
                var sectionGrabbed = section()
                sectionGrabbed = entry.data as! section
        
                print(entry.data)
                print("The name of the section is", sectionGrabbed.name)
                print("The percentage of the course is", String(format : "%.0f",sectionGrabbed.percentageOfCourse) + "%")
        
                print("The percentage earned is", sectionGrabbed.percentageEarned, "%")
                print("The grades of the section are", sectionGrabbed.grades)
        
                for aSection in coursesSections {
                    if (aSection.name == sectionGrabbed.name) {
                        self.selectedSection = aSection
                    }
                }
        
        print("the selected section is " + selectedSection.name)
        gradesTableView.reloadData()
                
        //        self.pieChartView.setNeedsDisplay()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (selectedSection.grades.count != 0) {
            return selectedSection.grades.count
        }
        else {
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.gradesTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let grade = self.selectedSection.grades[indexPath.row]
        let value = grade.value
        cell.textLabel?.text = "\(value)"
        
        return cell
    }
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        circleMenu.buttonsCount = 4
        circleMenu.duration = 2
        circleMenu.distance = 70
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        switch atIndex {
        case 0:
            let gradesLeft = Int(gradesLeftTF.text!)
            let mockGrades = selectedSection.grades
            let copySection = selectedSection
            print(copySection.findBestGradeWith(gradesLeft: 5))
//           let bestGrade = self.findBestGrade(grades: mockGrades, gradesLeft: gradesLeft!)
        case 1:
            print("Find Grade needed for certain grade in section")
            let gradeDesired = Int(gradesLeftTF.text!)
            
        case 2:
            print("Second one")
        case 3:
            print("Third one")
        default:
            print("None of them")
        }
    }
    
    func findBestGrade(grades: List<Grade>, gradesLeft: Int) -> Int {
       
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//  Mark: Reserved old code
    
//    @IBAction func getBestGradeForSelectedSection(sender: AnyObject) {
//        let gradesLeft = Int(gradesLeftTF.text!)
//        print(gradesLeft)
//        print(aCourse.bestGradePossibleForSection(gradesLeft: gradesLeft!, sectionName: selectedSection.name))
//        
//    }
    
    /*
    // MARK: - CAShapeLayer - old
    func createSlice (startAngle: CGFloat, endAngle: CGFloat, fill: Bool, color: UIColor, opacity: Float) {
        let newSlice = CAShapeLayer()
        
        //var center = CGPointMake((self.view.frame.width/2), (self.view.frame.height/2))
        let center = self.view.center
        
        let radius = 200
        
        if (fill == true) {
            
            let slicePath2 = UIBezierPath ()
            
            slicePath2.addArc(withCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: endAngle, clockwise:true)
            
            slicePath2.addLine(to: center)
            
            slicePath2.close()
            
            
            //newSlice.path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: endAngle, clockwise:true).CGPath
            
            newSlice.path = slicePath2.cgPath
            
            //newSlice.lineWidth = 200
        }
            
        else {
            newSlice.path = UIBezierPath(arcCenter: center, radius: CGFloat(100), startAngle: startAngle, endAngle: endAngle, clockwise:true).cgPath
            newSlice.lineWidth = 1
            
        }
        
        newSlice.frame = self.view.layer.bounds
        newSlice.position = self.view.center
        
        
        // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
        
        
        // Configure the circle
        newSlice.fillColor = color.cgColor
        //newSlice.fillColor = UIColor.whiteColor().CGColor
        newSlice.opacity = opacity
        newSlice.strokeColor = color.cgColor
        
        
        // When it gets to the end of its animation, leave it at 0% stroke filled
        newSlice.strokeEnd = 0.0
        
        //newSlice.frame = self.pieGraphView.layer.bounds
        
        //add slice to array
        slices.append(newSlice)
        
        // Add the circle to the parent layer
        self.view.layer.addSublayer(newSlice)
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.repeatCount = 1.0
        drawAnimation.fromValue = NSNumber(value: 0.0)
        drawAnimation.toValue = NSNumber(value: 1.0)
        drawAnimation.duration = 5.0
        drawAnimation.fillMode = kCAFillModeForwards
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        
        let fillAnimation = CABasicAnimation(keyPath: "fillColor")
        fillAnimation.repeatCount = 1.0
        fillAnimation.fromValue = UIColor.white.cgColor
        fillAnimation.toValue = color.cgColor
        fillAnimation.duration = 5.0
        
        fillAnimation.fillMode = kCAFillModeBoth
        fillAnimation.isRemovedOnCompletion = false
        
        fillAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Add the animation to the circle
        newSlice.add(drawAnimation, forKey: "drawCircleAnimation")
        newSlice.add(fillAnimation, forKey: fillAnimation.keyPath)
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
        for index in 1 ..< courseSections.count {
            pieEndPointDegrees.append(CGFloat(courseSections[index].percentageOfCourse) + endDegree)
            endDegree = pieEndPointDegrees[index]
        }
        
        print("The splits in degree of the pie:")
        print(pieEndPointDegrees)
        
        for index1 in 0 ..< pieEndPointDegrees.count {
            pieEndPointInRadians.append(degree2radian(a: CGFloat(pieEndPointDegrees[index1])))
        }
        
        for section in courseSections {
            percentageOfSectionEarned.append(CGFloat(section.percentageEarned * section.percentageOfCourse))
        }
        
        print("percentage of section earned")
        print(percentageOfSectionEarned)
        
        for percentageEarned in percentageOfSectionEarned {
            percentageOfSectionEarnedInRadians.append(degree2radian(a: percentageEarned))
        }
        
        // print("percentage of section earned in radians")
        // print(percentageOfSectionEarnedInRadians)
        // print("\n")
        
        endOfSectionInDegrees.append(percentageOfSectionEarned[0])
        for index2 in 1 ..< pieEndPointDegrees.count {
            endOfSectionInDegrees.append(pieEndPointDegrees[index2-1] + percentageOfSectionEarned[index2])
        }
        
        print("end of section in degrees")
        print(endOfSectionInDegrees)
        
        endOfSectionInRadians.append(percentageOfSectionEarnedInRadians[0])
        for index3 in 1 ..< endOfSectionInDegrees.count {
            endOfSectionInRadians.append(degree2radian(a: endOfSectionInDegrees[index3]))
        }
        
        // print("end of section in radians")
        // print(endOfSectionInRadians)
        
        
        // Draw the slices
        
        var someColor = getRandomColor()
        
        createSlice(startAngle: 0.0, endAngle: endOfSectionInRadians[0], fill: true, color: someColor, opacity: 1.0)
        createSlice(startAngle: endOfSectionInRadians[0], endAngle: pieEndPointInRadians[0], fill: true, color: someColor,opacity: 0.1)
        
        for a in 1 ..< courseSections.count {
            
            someColor = getRandomColor()
            createSlice(startAngle: endOfSectionInRadians[a], endAngle: pieEndPointInRadians[a], fill: true, color: someColor, opacity:  0.1)
            createSlice(startAngle: pieEndPointInRadians[a-1], endAngle: endOfSectionInRadians[a], fill: true, color: someColor, opacity: 1.0)
            
        }
    }
 */
    
    //    func addSecondLayer () {
    //        let newSlice = CAShapeLayer()
    //
    //        let slicePath = UIBezierPath ()
    //
    //        var center = self.pieChartView.center
    //        //
    //        slicePath.addArc(withCenter: center, radius: CGFloat(100), startAngle: 0, endAngle: degree2radian(a: 90.0), clockwise:true)
    //
    //        let closingPoint = CGPoint(x: (center.x), y: center.y+50)
    //
    //        slicePath.addLine(to: closingPoint)
    //        slicePath.addArc(withCenter: center, radius: CGFloat(40), startAngle: degree2radian(a: 90.0), endAngle: 0, clockwise: false)
    //
    //        slicePath.close()
    //
    //        newSlice.path = slicePath.cgPath
    //        let patternedImage = UIImage(imageLiteralResourceName: "diagonalStriped")
    //
    //        newSlice.fillColor = UIColor(patternImage: patternedImage).cgColor
    //        
    //        self.pieChartView.layer.addSublayer(newSlice)
    //    }

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
