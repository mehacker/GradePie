//
//  account.swift
//  GradePie
//
//  Created by Nathan Nguyen on 5/10/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
//import AWSDynamoDB

class account : Object {
    dynamic var username = ""
    dynamic var password = ""
//  dynamic var parent = ""
    dynamic var student : student? = nil
    
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

