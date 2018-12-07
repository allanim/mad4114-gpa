//
//  Student.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-06.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation

struct Student {
    var name: String
    var grades: [Grade] = []
    
    init(name:String) {
        self.name = name
    }
    
    mutating func addGrade(grade:Grade) {
        self.grades.append(grade)
    }
    
    var totalCredit: Int {
        
        var total = 0
        for grade in self.grades {
            total += grade.cource.credit
        }
        return total
    }
    
    var totalWeightedGradePoint: Double {
        var total = 0.0
        for grade in self.grades {
            total += grade.weightedGradePoint
        }
        return total
    }
    
    var gpa: Double {
        return (self.totalWeightedGradePoint / Double(self.totalCredit) * 1000).rounded() / 1000
    }
}
