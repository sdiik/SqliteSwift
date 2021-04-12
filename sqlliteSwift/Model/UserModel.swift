//
//  UserModel.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 09/04/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import Foundation

class UserModel: Identifiable {
    public var id: Int64 = 0
    public var name: String = ""
    public var email: String = ""
    public var age: Int64 = 0
    
}
