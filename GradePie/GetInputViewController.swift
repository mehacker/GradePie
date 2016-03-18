//
//  GetInputViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/18/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

class GetInputViewController: UIViewController {

  
    @IBOutlet weak var sectionName: UITextField!
  
    @IBOutlet weak var sectionPercentage: UITextField!
    
    @IBOutlet weak var percentageEarned: UITextField!
    
    var sectionsToAdd = [section] ()
    
    var courseToPass = course ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addSetion(sender: AnyObject) {
        let newSection = section()
        
        var percentageOfCourse:Float?  = Float(sectionPercentage.text!)
        percentageOfCourse = (percentageOfCourse!/100) * 360

        newSection.percentageOfCourse = percentageOfCourse!
        
        let percentageOfCourseEarned:Float?  = Float(percentageEarned.text!)
        newSection.percentageEarned = percentageOfCourseEarned!
        
        sectionsToAdd.append(newSection)
    }

    @IBAction func addCourse(sender: AnyObject) {
        courseToPass.sections = sectionsToAdd
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var svc = segue.destinationViewController as! CAShapeTestViewController
        
        svc.courseSections = sectionsToAdd
    }


}
