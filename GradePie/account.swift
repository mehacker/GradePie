//
//  Account.swift
//  GradePie
//
//  Created by Nathan Nguyen on 12/21/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
//import AWSDynamoDB

class Account : Object {
    dynamic var username = ""
    dynamic var password = ""
    //  dynamic var parent = ""
    dynamic var student : Student? = nil
    
    override static func primaryKey() -> String? {
        return "username"
    }
    
    func save () {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
