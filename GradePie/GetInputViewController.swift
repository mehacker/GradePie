//
//  GetInputViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/18/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

//import AWSDynamoDB
//import AWSCognito

import UIKit
import RealmSwift

class GetInputViewController: UIViewController {
    
    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var sectionName: UITextField!
    
    @IBOutlet weak var sectionPercentage: UITextField!
    
    @IBOutlet weak var percentageEarned: UITextField!
    
    var theSchool = school ()
    
    var courseToPass = course ()
    
    var sectionsToAdd = List<section>()
    
    var currentStudent = Student ()
    
    var loggedInAccount = Account ()
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
        
    //Old AWS
        
//        let dynamoDB = AWSDynamoDB.default()
//        let listTableInput = AWSDynamoDBListTablesInput()
//        dynamoDB.listTables(listTableInput!).continue(successBlock: { (task: AWSTask?) -> AnyObject? in
//            if let error = task!.error {
//                print("Error occurred: \(error)")
//                return nil
//            }
//            
//            let listTablesOutput = task!.result as AWSDynamoDBListTablesOutput!
//            
//            for tableName in (listTablesOutput?.tableNames!)! {
//                print("\(tableName)")
//            }
//            
//            return nil
//        })

//        newTable.sectionTitle = "test"
//        newTable.Userid = "test"
//        newTable.Grade = 100
//        newTable.PercentageOfCourse = 100
        
        //setup table in aws
//        self.setupTable()

    }
    
    func setUpGrades () {
        
    }
    
    @IBAction func addSection(_ sender: Any) {
        let newSection = section()
        
        newSection.name = sectionName.text!
        
        let percentageOfCourse:Float?  = Float(sectionPercentage.text!)
        
        newSection.percentageOfCourse = percentageOfCourse!
        
        let percentageOfCourseEarned:Float?  = Float(percentageEarned.text!)
        newSection.percentageEarned = percentageOfCourseEarned!
        
        let grade = Grade()
        grade.grade = 50
        let grade1 = Grade()
        grade1.grade = 87
        let grade2 = Grade()
        grade2.grade = 100
        let grade3 = Grade()
        grade3.grade = 90
        let grade4 = Grade()
        grade4.grade = 77
        
        newSection.grades.append(grade)
        newSection.grades.append(grade1)
        newSection.grades.append(grade2)
        newSection.grades.append(grade3)
        newSection.grades.append(grade4)
        
        sectionsToAdd.append(newSection)
        
        courseToPass.sections = sectionsToAdd
        
        //      let newTable = DDBTableRow()
        //      self.insertTableRow(tableRow: newTable!)
    }
    
    @IBAction func addCourse(_ sender: Any) {
        
        courseToPass.name = courseName.text!
        courseToPass.sections = sectionsToAdd
        
        var newAccount = Account()
        
        var courses = List<course> ()
        
        let realm = try! Realm()
        
//      let usernameSearch = realm.objects(Account.self).filter("username = %@ AND password = %a", loggedInAccount.username, loggedInAccount.password)
        
        let usernameSearch = realm.objects(Account.self).filter("username = %@ AND password = %a", "tester", "password")
        
        loggedInAccount = usernameSearch[0]
        
        let studentOfAccount = loggedInAccount.student
        
        try! realm.write {
            studentOfAccount?.courses.append(courseToPass)
        }
    
//        let updatedAccount = Account ()
//        
//        updatedAccount.username = "tester"
//        updatedAccount.password = "password"
//        updatedAccount.student = studentOfAccount
//        
//        try! realm.write {
//            realm.add(updatedAccount)
//        }
        
//        try! realm.write {
//            realm.create(Account.self, value: ["password": "password", "username": "tester"], update: true)
//        }
        
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    func setupTable() {
    //        //See if the test table exists.
    //        DDBDynamoDBManager.describeTable().continue(with: AWSExecutor.mainThread(), with: { (task:AWSTask!) -> AnyObject! in
    //
    //            // If the test table doesn't exist, create one.
    ////            if (task.error != nil && task.error!.domain == AWSDynamoDBErrorDomain)
    ////                && (task.error!.code == AWSDynamoDBErrorType.ResourceNotFound.rawValue) {
    //
    ////                self.performSegueWithIdentifier("DDBLoadingViewSegue", sender: self)
    //
    //                return DDBDynamoDBManager.createTable().continue(with: AWSExecutor.mainThread(), with: { (task:AWSTask!) -> AnyObject! in
    //                    //Handle erros.
    //                    if ((task.error) != nil) {
    //                        print("Error: \(task.error)")
    //
    //                        let alertController = UIAlertController(title: "Failed to setup a test table.", message: task.error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
    //                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) -> Void in
    //                        })
    //                        alertController.addAction(okAction)
    //
    //                        self.present(alertController, animated: true, completion: nil)
    //
    //                    } else {
    //                        self.dismiss(animated: false, completion: nil)
    //                    }
    //                    return nil
    //
    //                })
    ////            } else {
    //                //load table contents
    ////                self.refreshList(true)
    ////            }
    //
    ////            return nil
    //        })
    //    }
    
    //    func insertTableRow(tableRow: DDBTableRow) {
    //        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    //
    //        dynamoDBObjectMapper.save(tableRow).continue(with: AWSExecutor.mainThread(), with: { (task:AWSTask!) -> AnyObject! in
    //            if (task.error == nil) {
    //                let alertController = UIAlertController(title: "Succeeded", message: "Successfully inserted the data into the table.", preferredStyle: UIAlertControllerStyle.alert)
    //                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) -> Void in
    //                })
    //                alertController.addAction(okAction)
    //                self.present(alertController, animated: true, completion: nil)
    //
    //            } else {
    //                print("Error: \(task.error)")
    //
    //                let alertController = UIAlertController(title: "Failed to insert the data into the table.", message: task.error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
    //                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) -> Void in
    //                })
    //                alertController.addAction(okAction)
    //                self.present(alertController, animated: true, completion: nil)
    //            }
    //            
    //            return nil
    //        })
    //            
    //    }
}
