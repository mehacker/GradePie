//
//  Course.swift
//  GradePie
//
//  Created by Nathan Nguyen on 1/18/16.
//  Copyright © 2016 Nathan Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class course : Object {
    
    dynamic var name = ""
    
    dynamic var percentageEarned = 0
    
    var sections = List<section>()
    
    func getSection (name: String) -> section {
        var sectionFound = section()
        for section in sections {
            if (name == section.name) {
                sectionFound = section
            }
        }
        return sectionFound
    }
    
//    func bestGradePossibleForSection(gradesLeft: Int, sectionName: String) -> Float {
//        var bestGrade: Float = 0.0
//        
//        var mockSection =  section()
//        let sectionSearched = getSection(name: sectionName)
//        mockSection = sectionSearched
//        
//        print(mockSection.grades)
//        
//        for _ in 0..<gradesLeft {
//            mockSection.addGrade(grade: 100)
//        }
//        
//        bestGrade = mockSection.getPercentageOfCourseEarned()
//        
//        return bestGrade
//    }
    
}

