//
//  GetInputViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/18/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit

class GetInputViewController: UIViewController {

    @IBOutlet weak var percentageOfSectionTF: UITextField!
    
    var sectionsToAdd = [section] ()
    
    var courseToPass = course ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseToPass.name = "math"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addSection(sender: AnyObject) {
        var newSection = section ()
        newSection.percentageEarned = Double(percentageOfSectionTF.text!)!
        sectionsToAdd.append(newSection)
    }

    @IBAction func addCourse(sender: AnyObject) {
        courseToPass.sections = sectionsToAdd
        var hundred = 100.0
        for section in sectionsToAdd {
            hundred -= section.percentageEarned
            
        }
        
        if (hundred > 0) {
            print("incomplete course ")
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextVC = segue.destinationViewController as! Graph
        nextVC.aCourse = courseToPass
    }


}
