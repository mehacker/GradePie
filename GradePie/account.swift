//
//  account.swift
//  GradePie
//
//  Created by Nathan Nguyen on 5/10/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

//class account : Object {
class account : Object {
    dynamic var username = ""
    dynamic var password = ""
    dynamic var aStudent : student? = nil
}
