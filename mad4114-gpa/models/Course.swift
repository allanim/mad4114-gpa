//
//  Course.swift
//  mad4114-gpa
//
//  Created by Allan Im on 2018-12-06.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import Foundation

struct Course {
    var term: Int
    var code: String
    var name: String
    var credit: Int
    
    init(term: Int, code: String, name: String, credit: Int) {
        self.code = code
        self.name = name
        self.term = term
        self.credit = credit
    }
    
}
