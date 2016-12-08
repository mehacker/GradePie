//
//  CreateStudentViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 4/11/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit
import AWSCognito
import AWSDynamoDB
//import RealmSwift


class CreateStudentViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var aStudent = student ()
    
    var aAccount = account ()
    
    var lastEvaluatedKey:[String : AWSDynamoDBAttributeValue]!
    
    //let realm = try! Realm ()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        aStudent.firstName = "Nathan"
        
        aStudent.lastName = "Nguyen"
      //  aSchool.name = "Georgia State University"
        
    }
    
    @IBAction func login(sender: AnyObject) {
        let username = usernameTextField.text!
    
        
//        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
//        let queryExpression = AWSDynamoDBQueryExpression()
//
//        queryExpression.hashKeyValues = "Username"
//        queryExpression.hashKeyAttribute = "tester"
//        queryExpression.exclusiveStartKey = lastEvaluatedKey.self
//        
//        let aRow = DDBTableRow()
//        
//        queryExpression.limit = 10
//        
//        
//        //putting it all together
//        let dynamoDBObjectMapper2 = AWSDynamoDBObjectMapper.default()
//        
//        dynamoDBObjectMapper2.query(DDBTableRow.self, expression: queryExpression) .continue(with: AWSExecutor.mainThread(), with: { (task:AWSTask!) -> AnyObject! in
//            if (task.error == nil) {
//                if (task.result != nil) {
//                    NSLog("Somthing happened")
//                    //starting the output of data
//                    let tableRow = task.result as! AWSDynamoDBPaginatedOutput?
//                    for (item) in (tableRow?.items)! {
//                        print(item)
//                    }
//                }
//            }
//            else {
//                print("Error: \(task.error)")
//                
//            }
//            return nil
//        })
}



        
      //  let searchAccount = realm.objects(account).filter("username = %@", username)
//        if (searchAccount.count == 1) {
//            print ("login sucessful")
//            
//            let mainSB = UIStoryboard(name: "Main", bundle: nil)
//            
//            let inputVc = mainSB.instantiateViewControllerWithIdentifier("GetInputViewController") as! GetInputViewController
//            
//            self.presentViewController(inputVc, animated: true, completion: nil)
//            
//        } else {
//            errorMessage.text = "Login unsucessful"
//            
//            print ("login unsucessful")
//        }
    



    @IBAction func createStudentAccount(_ sender: Any) {
        aAccount.username = usernameTextField.text!
        aAccount.password = passwordTextField.text!
        aAccount.aStudent = aStudent
        
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //try! realm.write {
        //            realm.add(aAccount)
        //        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
           let svc = segue.destination as! GetInputViewController
    
           svc.currentStudent = aStudent
    }
}
