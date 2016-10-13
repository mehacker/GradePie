//
//  GetInputViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/18/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import AWSDynamoDB
import AWSCognito
import UIKit

class GetInputViewController: UIViewController {
    
    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var sectionName: UITextField!
    
    @IBOutlet weak var sectionPercentage: UITextField!
    
    @IBOutlet weak var percentageEarned: UITextField!
    
    // let realm = try! Realm ()
    
    var theSchool = school ()
    
    var courseToPass = course ()
    
    var sectionsToAdd = [section] ()
    
    var currentStudent = student ()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let dynamoDB = AWSDynamoDB.defaultDynamoDB()
        let listTableInput = AWSDynamoDBListTablesInput()
        dynamoDB.listTables(listTableInput).continueWithBlock{ (task: AWSTask?) -> AnyObject? in
            if let error = task!.error {
                print("Error occurred: \(error)")
                return nil
            }
            
            let listTablesOutput = task!.result as! AWSDynamoDBListTablesOutput
            
            for tableName in listTablesOutput.tableNames! {
                print("\(tableName)")
            }
            
            return nil
        }

//        newTable.sectionTitle = "test"
//        newTable.Userid = "test"
//        newTable.Grade = 100
//        newTable.PercentageOfCourse = 100
        
        self.setupTable()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTable() {
        //See if the test table exists.
        DDBDynamoDBManager.describeTable().continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            
            // If the test table doesn't exist, create one.
//            if (task.error != nil && task.error!.domain == AWSDynamoDBErrorDomain)
//                && (task.error!.code == AWSDynamoDBErrorType.ResourceNotFound.rawValue) {
            
//                self.performSegueWithIdentifier("DDBLoadingViewSegue", sender: self)
            
                return DDBDynamoDBManager.createTable().continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
                    //Handle erros.
                    if ((task.error) != nil) {
                        print("Error: \(task.error)")
                        
                        let alertController = UIAlertController(title: "Failed to setup a test table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                        })
                        alertController.addAction(okAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    } else {
                        self.dismissViewControllerAnimated(false, completion: nil)
                    }
                    return nil
                    
                })
//            } else {
                //load table contents
//                self.refreshList(true)
//            }
            
//            return nil
        })
    }
    
    func insertTableRow(tableRow: DDBTableRow) {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        dynamoDBObjectMapper.save(tableRow).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                let alertController = UIAlertController(title: "Succeeded", message: "Successfully inserted the data into the table.", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                print("Error: \(task.error)")
                
                let alertController = UIAlertController(title: "Failed to insert the data into the table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            return nil
        })
            
    }
    
    @IBAction func addSetion(sender: AnyObject) {
        let newSection = section()
        
        newSection.name = sectionName.text!
        
        var percentageOfCourse:Float?  = Float(sectionPercentage.text!)
        
        newSection.percentageOfCourse = percentageOfCourse!
        
        let percentageOfCourseEarned:Float?  = Float(percentageEarned.text!)
        newSection.percentageEarned = percentageOfCourseEarned!
        
        sectionsToAdd.append(newSection)
        
        let newTable = DDBTableRow()
        self.insertTableRow(newTable)
        
        //        try! realm.write {
        //            realm.add(newSection)
        //        }
        
    }
    
    @IBAction func addCourse(sender: AnyObject) {
        //courseToPass.sections = sectionsToAdd
        
        courseToPass.sections = sectionsToAdd
        courseToPass.name = courseName.text!
        //theSchool.courses.append(courseToPass)
        
        // courseToPass.sections = sectionsToAdd
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var svc = segue.destinationViewController as! CAShapeTestViewController
        
        svc.courseSections = sectionsToAdd
        
        svc.aCourse = courseToPass
        
        svc.currentStudent = currentStudent
    }
    
}