//
//  account.swift
//  GradePie
//
//  Created by Nathan Nguyen on 5/10/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import AWSDynamoDB
//import RealmSwift

// For Realm
//class account : Object {

// For AWS
class account  {
    var username = ""
    var password = ""
    var aStudent : student? = nil
}
