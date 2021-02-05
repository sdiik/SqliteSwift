//
//  Person.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 03/02/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import Foundation

class Person {
    var name: String = ""
    var age: Int = 0
    var id: Int = 0
    
    init(id: Int, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}
