//
//  Section.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/9/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

//class section : Object {
class section {
    
    dynamic var name = ""
    
    dynamic var percentageOfCourse:Float = 0.0
    
    dynamic var percentageEarned:Float = 0.0
    
    var grades = [Int]()
    
    func addGrade (grade: Int) {
        grades.append(grade)
    }
    
    func removeGrade (grade: Int) {
        for i in 0 ..< grades.count {
            if (grade == grades[i]) {
                grades.removeAtIndex(i)
            }
            
        }
    }
}

