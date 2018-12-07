//
//  StudentStore.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-06.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation

struct StudentStore {
    static var students: [Student] = []
    static var cources: [Int: Course] = [:]
    
    static func initData() {
        initCources()
        initStudent1()
        initStudent2()
        initStudent3()
        initStudent4()
        initStudent5()
    }
    
    static func addStudent(student: Student) {
        self.students.append(student)
    }
    
    static func initCources() {
        self.cources[11] = Course(term: 1, code: "CSD 2204", name: "Database Design & SQL", credit: 4)
        self.cources[12] = Course(term: 1, code: "MAD 3004", name: "Introduction to Swift Programming", credit: 4)
        self.cources[13] = Course(term: 1, code: "MAD 3464", name: "Programming Java I", credit: 4)
        self.cources[14] = Course(term: 1, code: "MAD 3115", name: "iOS Programming Fundamentals", credit: 5)
        self.cources[15] = Course(term: 1, code: "MAD 3125", name: "Android Development Fundamentals", credit: 5)
        
        self.cources[21] = Course(term: 2, code: "CPP 1001", name: "Co-Op Preparation", credit: 1)
        self.cources[22] = Course(term: 2, code: "MAD 3134", name: "Web Application Development using PHP and MySQL", credit: 4)
        self.cources[23] = Course(term: 2, code: "MAD 3144", name: "Development for the Mobile Web", credit: 4)
        self.cources[24] = Course(term: 2, code: "MAD 4103", name: "Cross Platform Mobile Application Development", credit: 3)
        self.cources[25] = Course(term: 2, code: "MAD 4114", name: "Advanced iOS Application Development", credit: 4)
        self.cources[26] = Course(term: 2, code: "MAD 4124", name: "Advanced Android Application Development", credit: 4)
    }
    
    static func initStudent1() {
        var student = Student(name: "Seongyeob Im");
        student.addGrade(grade: Grade(cource: self.cources[11]!, grade: Mark.AP))
        student.addGrade(grade: Grade(cource: self.cources[12]!, grade: Mark.AP))
        student.addGrade(grade: Grade(cource: self.cources[13]!, grade: Mark.AM))
        student.addGrade(grade: Grade(cource: self.cources[14]!, grade: Mark.A))
        student.addGrade(grade: Grade(cource: self.cources[15]!, grade: Mark.AM))
        student.addGrade(grade: Grade(cource: self.cources[21]!, grade: Mark.BM))
        student.addGrade(grade: Grade(cource: self.cources[22]!, grade: Mark.AP))
        student.addGrade(grade: Grade(cource: self.cources[23]!, grade: Mark.AP))
        student.addGrade(grade: Grade(cource: self.cources[24]!, grade: Mark.AP))
        student.addGrade(grade: Grade(cource: self.cources[25]!, grade: Mark.AP))
        student.addGrade(grade: Grade(cource: self.cources[26]!, grade: Mark.AP))
        self.students.append(student)
    }
    
    static func initStudent2() {
        var student = Student(name: "Student Allan");
        student.addGrade(grade: Grade(cource: self.cources[11]!, grade: Mark.AM))
        student.addGrade(grade: Grade(cource: self.cources[12]!, grade: Mark.A))
        student.addGrade(grade: Grade(cource: self.cources[13]!, grade: Mark.AP))
        student.addGrade(grade: Grade(cource: self.cources[14]!, grade: Mark.BP))
        student.addGrade(grade: Grade(cource: self.cources[15]!, grade: Mark.AM))
        student.addGrade(grade: Grade(cource: self.cources[21]!, grade: Mark.B))
        student.addGrade(grade: Grade(cource: self.cources[22]!, grade: Mark.A))
        student.addGrade(grade: Grade(cource: self.cources[23]!, grade: Mark.BP))
        student.addGrade(grade: Grade(cource: self.cources[24]!, grade: Mark.BM))
        student.addGrade(grade: Grade(cource: self.cources[25]!, grade: Mark.BP))
        student.addGrade(grade: Grade(cource: self.cources[26]!, grade: Mark.AM))
        self.students.append(student)
    }
    
    static func initStudent3() {
        var student = Student(name: "Student Monica");
        student.addGrade(grade: Grade(cource: self.cources[11]!, grade: Mark.BM))
        student.addGrade(grade: Grade(cource: self.cources[12]!, grade: Mark.AM))
        student.addGrade(grade: Grade(cource: self.cources[13]!, grade: Mark.BM))
        student.addGrade(grade: Grade(cource: self.cources[14]!, grade: Mark.B))
        student.addGrade(grade: Grade(cource: self.cources[15]!, grade: Mark.CP))
        student.addGrade(grade: Grade(cource: self.cources[21]!, grade: Mark.CM))
        student.addGrade(grade: Grade(cource: self.cources[22]!, grade: Mark.BM))
        student.addGrade(grade: Grade(cource: self.cources[23]!, grade: Mark.B))
        student.addGrade(grade: Grade(cource: self.cources[24]!, grade: Mark.CP))
        student.addGrade(grade: Grade(cource: self.cources[25]!, grade: Mark.C))
        student.addGrade(grade: Grade(cource: self.cources[26]!, grade: Mark.D))
        self.students.append(student)
    }
    
    static func initStudent4() {
        var student = Student(name: "Student Joy");
        student.addGrade(grade: Grade(cource: self.cources[11]!, grade: Mark.D))
        student.addGrade(grade: Grade(cource: self.cources[12]!, grade: Mark.CP))
        student.addGrade(grade: Grade(cource: self.cources[13]!, grade: Mark.D))
        student.addGrade(grade: Grade(cource: self.cources[14]!, grade: Mark.BM))
        student.addGrade(grade: Grade(cource: self.cources[15]!, grade: Mark.C))
        student.addGrade(grade: Grade(cource: self.cources[21]!, grade: Mark.F))
        student.addGrade(grade: Grade(cource: self.cources[22]!, grade: Mark.D))
        student.addGrade(grade: Grade(cource: self.cources[23]!, grade: Mark.CP))
        student.addGrade(grade: Grade(cource: self.cources[24]!, grade: Mark.C))
        student.addGrade(grade: Grade(cource: self.cources[25]!, grade: Mark.D))
        student.addGrade(grade: Grade(cource: self.cources[26]!, grade: Mark.F))
        self.students.append(student)
    }
    
    static func initStudent5() {
        var student = Student(name: "Student Albert");
        student.addGrade(grade: Grade(cource: self.cources[11]!, grade: Mark.CM))
        student.addGrade(grade: Grade(cource: self.cources[12]!, grade: Mark.D))
        student.addGrade(grade: Grade(cource: self.cources[13]!, grade: Mark.CM))
        student.addGrade(grade: Grade(cource: self.cources[14]!, grade: Mark.CP))
        student.addGrade(grade: Grade(cource: self.cources[15]!, grade: Mark.C))
        student.addGrade(grade: Grade(cource: self.cources[21]!, grade: Mark.D))
        student.addGrade(grade: Grade(cource: self.cources[22]!, grade: Mark.CP))
        student.addGrade(grade: Grade(cource: self.cources[23]!, grade: Mark.BP))
        student.addGrade(grade: Grade(cource: self.cources[24]!, grade: Mark.B))
        student.addGrade(grade: Grade(cource: self.cources[25]!, grade: Mark.CM))
        student.addGrade(grade: Grade(cource: self.cources[26]!, grade: Mark.C))
        self.students.append(student)
    }
}
