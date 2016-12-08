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
        
        let dynamoDB = AWSDynamoDB.default()
        let listTableInput = AWSDynamoDBListTablesInput()
        dynamoDB.listTables(listTableInput!).continue(successBlock: { (task: AWSTask?) -> AnyObject? in
            if let error = task!.error {
                print("Error occurred: \(error)")
                return nil
            }
            
            let listTablesOutput = task!.result as AWSDynamoDBListTablesOutput!
            
            for tableName in (listTablesOutput?.tableNames!)! {
                print("\(tableName)")
            }
            
            return nil
        })

//        newTable.sectionTitle = "test"
//        newTable.Userid = "test"
//        newTable.Grade = 100
//        newTable.PercentageOfCourse = 100
        
        //setup table in aws
//        self.setupTable()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTable() {
        //See if the test table exists.
        DDBDynamoDBManager.describeTable().continue(with: AWSExecutor.mainThread(), with: { (task:AWSTask!) -> AnyObject! in
            
            // If the test table doesn't exist, create one.
//            if (task.error != nil && task.error!.domain == AWSDynamoDBErrorDomain)
//                && (task.error!.code == AWSDynamoDBErrorType.ResourceNotFound.rawValue) {
            
//                self.performSegueWithIdentifier("DDBLoadingViewSegue", sender: self)
            
                return DDBDynamoDBManager.createTable().continue(with: AWSExecutor.mainThread(), with: { (task:AWSTask!) -> AnyObject! in
                    //Handle erros.
                    if ((task.error) != nil) {
                        print("Error: \(task.error)")
                        
                        let alertController = UIAlertController(title: "Failed to setup a test table.", message: task.error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) -> Void in
                        })
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else {
                        self.dismiss(animated: false, completion: nil)
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
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDBObjectMapper.save(tableRow).continue(with: AWSExecutor.mainThread(), with: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                let alertController = UIAlertController(title: "Succeeded", message: "Successfully inserted the data into the table.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                print("Error: \(task.error)")
                
                let alertController = UIAlertController(title: "Failed to insert the data into the table.", message: task.error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            return nil
        })
            
    }
    
    @IBAction func addSection(_ sender: Any) {
        let newSection = section()
        
        newSection.name = sectionName.text!
        
        let percentageOfCourse:Float?  = Float(sectionPercentage.text!)
        
        newSection.percentageOfCourse = percentageOfCourse!
        
        let percentageOfCourseEarned:Float?  = Float(percentageEarned.text!)
        newSection.percentageEarned = percentageOfCourseEarned!
        
        sectionsToAdd.append(newSection)
        
//        let newTable = DDBTableRow()
//        self.insertTableRow(tableRow: newTable!)
        
        //        try! realm.write {
        //            realm.add(newSection)
        //        }
    }

    
    @IBAction func addCourse(_ sender: Any) {
        //courseToPass.sections = sectionsToAdd
        
        courseToPass.sections = sectionsToAdd
        courseToPass.name = courseName.text!
        //theSchool.courses.append(courseToPass)
        
        // courseToPass.sections = sectionsToAdd
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      //  let svc = segue.destination as! CAShapeTestViewController
//        
//        svc.courseSections = sectionsToAdd
//        
//        svc.aCourse = courseToPass
//        
//        svc.currentStudent = currentStudent
    }
    
}
