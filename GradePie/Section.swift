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
    
    var grades = [Float]()
    
    var selected = false
    
    func addGrade (grade: Float) {
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
            total += grade
        }
        
        average = total/Float(grades.count)
        return average
    }
    
    func getPercentageOfCourseEarned ()  -> Float {
        percentageEarned = (getAverage()  * percentageOfCourse)/100
        return percentageEarned
    }

}

