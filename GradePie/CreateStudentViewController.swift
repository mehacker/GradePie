//
//  CreateStudentViewController.swift
//  GradePie
//
//  Created by Nathan Nguyen on 4/11/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import UIKit
import RealmSwift


class CreateStudentViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var aStudent = student ()
    
    var aAccount = account ()
    
    //let realm = try! Realm ()
    

    
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        aStudent.firstName = "Nathan"
        
        aStudent.lastName = "Nguyen"
      //  aSchool.name = "Georgia State University"
        
    }
    
    
    @IBAction func login(sender: AnyObject) {
        let username = usernameTextField.text!
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
    }

    @IBAction func createAccount(sender: AnyObject) {
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
           let svc = segue.destinationViewController as! GetInputViewController
    
           svc.currentStudent = aStudent
    }
}
