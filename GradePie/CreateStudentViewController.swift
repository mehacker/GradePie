//
//  CreateStudentViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 4/11/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import RealmSwift
//import AWSCognito
//import AWSDynamoDB

class CreateStudentViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var aStudent = student ()
    var loggedInAccount = account ()
    
//  var lastEvaluatedKey:[String : AWSDynamoDBAttributeValue]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        aStudent.firstName = "Nathan"
        
        aStudent.lastName = "Nguyen"
      //  aSchool.name = "Georgia State University"
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
         print(Realm.Configuration.defaultConfiguration.fileURL!)
        
//        let realm = try! Realm()
//        
//        try! realm.write {
//            realm.create(account.self, value: ["username" : "tester", "student": aStudent], update: true)
//        }
        
//        let usernameSearch = realm.object(account.self).filter("username = %@ AND password = %a", "tester", "password")
        
//        usernameSearch.student = aStudent
        
    }
    
    //Check login credentials 
    //Todo: Add security and encription
    @IBAction func login(sender: AnyObject) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!

            let realm = try! Realm()
                let usernameSearch = realm.objects(account.self).filter("username = %@ AND password = %a", username, password)
//                let passwordSearch = realm.objects(account.self).filter("password = %@", password)
                if (usernameSearch.count == 1) {
                    
                    for account in usernameSearch {
                        loggedInAccount = account
                    }
                    
                    let mainSB = UIStoryboard(name: "Main", bundle: nil)
                    
                    let graphVC = mainSB.instantiateViewController(withIdentifier: "CAShapeTestViewController") as! CAShapeTestViewController
                    
                    graphVC.loggedInAccount = loggedInAccount
                    
                    self.present(graphVC, animated: true, completion: nil)
                } else {
                    print("login denied")
                }
    }

    //Old Aws query
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

    @IBAction func createStudentAccount(_ sender: Any) {
        let newAccount = account()
    
        newAccount.username = usernameTextField.text!
        newAccount.password = passwordTextField.text!
//        newAccount.aStudent = aStudent
        
        newAccount.save()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
