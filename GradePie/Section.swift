//
//  Section.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/9/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class section : Object {
    
    dynamic var name = ""
    
    dynamic var percentageOfCourse:Float = 0.0
    
    dynamic var percentageEarned:Float = 0.0
    
    var grades = List<Grade>()
    
    var selected = false
    
    func addGrade (grade: Grade) {
        grades.append(grade)
        getPercentageOfCourseEarned()
    }
    
//    func removeGrade (grade: Int) {
//        for i in 0 ..< grades.count {
//            if (Int(grade) == grades[i]) {
//                grades.removeAtIndex(i)
//            }
//            
//        }
//    }
    
    func getAverage () -> Float {
        var total:Float = 0.0
        var average:Float = 0.0
        print("The grades for the seciton is", grades)
        for grade in grades {
            total += grade.grade
        }
        
        average = total/Float(grades.count)
        return average
    }
    
    //Must be used to update realm database
    func getPercentageOfCourseEarned () {
        percentageEarned = (getAverage()  * percentageOfCourse)/100
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

class Grade : Object {
    dynamic var grade:Float = 0.0
}

