//
//  Grade.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-06.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation

struct Grade {
    var cource: Course
    var grade: Mark!
    
    init(cource: Course, grade: Mark) {
        self.cource = cource
        self.grade = grade
    }
    
    var gradeString: String {
        return self.grade.rawValue
    }
    
    var gradePoint: Double {
        var point = 0.0
        switch self.grade! {
        case .AP:
            point = 4.0
        case .A :
            point = 3.7
        case .AM :
            point  = 3.5
        case .BP :
            point  = 3.2
        case .B :
            point  = 3.0
        case .BM :
            point  = 2.7
        case .CP :
            point  = 2.3
        case .C :
            point  = 2.0
        case .CM :
            point  = 1.7
        case .D :
            point  = 1.0
        case .F :
            point  = 0.0
        }
        return point
    }
    
    var weightedGradePoint: Double {
        return Double(self.cource.credit) * self.gradePoint
    }
    
}

enum Mark: String {
    case AP = "A+"
    case A = "A"
    case AM = "A-"
    case BP = "B+"
    case B = "B"
    case BM = "B-"
    case CP = "C+"
    case C = "C"
    case CM = "C-"
    case D = "D"
    case F = "F"
}
