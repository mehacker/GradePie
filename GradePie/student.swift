//
//  student.swift
//  GradePie
//
//  Created by Nathan Nguyen on 4/7/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

//class student : Object {
class student : Object {
    
    dynamic var firstName = " "
    
    dynamic var lastName = " "
    
    dynamic var aSchool : school? = nil
    
    var courses = List<course> ()
    
}