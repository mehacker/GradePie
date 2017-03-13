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
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
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
    
    //should be computer average instead of get
    func getAverage () -> Float {
        var total:Float = 0.0
        var average:Float = 0.0
        print("The grades for the seciton is", grades)
        for grade in grades {
            total += grade.value
        }
        
        average = total/Float(grades.count)
        return average
    }
    
    //Must be used to update realm database
    func getPercentageOfCourseEarned () {
        percentageEarned = (getAverage()  * percentageOfCourse)/100
    }
    
    func findBestGradeWith(gradesLeft : Int) -> Float {
        var copyGrades = copyList(list: self.grades)
        for _ in 1...gradesLeft {
            let perfectGrade = Grade()
            perfectGrade.value = 100
            copyGrades.append(perfectGrade)
        }
        
        var total:Float = 0.0
        var average:Float = 0.0
        print("The grades for the seciton is", grades)
        for grade in copyGrades {
            total += grade.value
        }
        
        average = total/Float(copyGrades.count)
        return (average  * percentageOfCourse)/100
    }
    
    func copyList (list : List<Grade>) -> [Grade] {
        var copyList = [Grade]()
        for aGrade in list {
            let newGrade = Grade()
            newGrade.value = aGrade.value
            copyList.append(newGrade)
        }
        return copyList
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
    dynamic var value:Float = 0.0
}

