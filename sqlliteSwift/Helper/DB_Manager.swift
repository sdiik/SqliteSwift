//
//  DB_Manager.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 09/04/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import Foundation
import SQLite

class DB_Manager {
    
    //sqlite instance
    private var db: Connection!
    //table instance
    private var users: Table!
    //column instance of table
    private var id: Expression<Int64>!
    private var name: Expression<String>!
    private var email: Expression<String>!
    private var age: Expression<Int64>!
    
    // constructor of this class
    init() {
        do {
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            // create database connection
            db = try! Connection("\(path)/my_users.sqlite3")
            
            // creating table object
            users = Table("users")
            
            // create instances of each column
            id = Expression<Int64>("id")
            name = Expression<String>("name")
            email = Expression<String>("email")
            age = Expression<Int64>("age")
            
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                try! db.run(users.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(email, unique: true)
                    t.column(age)
                })
                
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
            
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Add new user
    public func addUser(nameValue: String, emailValue: String, ageValue: Int64) {
        do {
            try! db.run(users.insert(name <- nameValue, email <- emailValue, age <- ageValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - return array of user models
    public func getUsers() -> [UserModel] {
        var userModels: [UserModel] = []
        //get all users in descending order
        users = users.order(id.desc)
        
        //exception handling
        do {
            for user in try! db.prepare(users) {
                let userModel: UserModel = UserModel()
                userModel.id = user[id]
                userModel.name = user[name]
                userModel.email = user[email]
                userModel.age = user[age]
                
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        return userModels
    }
    
    //MARK: - get single user data
    public func getUser(idValue: Int64) -> UserModel {
        
        // create an empty object
        let userModel: UserModel = UserModel()
        
        //exception handing
        do {
            
            // get user using ID
            let user: AnySequence<Row> = try! db.prepare(users.filter(id == idValue))
            
            // get row
            try user.forEach({ (rowValue) in
                
                // set values in model
                userModel.id = try rowValue.get(id)
                userModel.name = try rowValue.get(name)
                userModel.email = try rowValue.get(email)
                userModel.age = try rowValue.get(age)
            })
            
        } catch {
            print(error.localizedDescription)
        }
        
        return userModel
    }
    
    //MARK: - Update user data
    public func updateUser(idValue: Int64, nameValue: String, emailValue: String, ageValue: Int64) {
        
        do {
            
            let user: Table = users.filter(id == idValue)
            
            // run the update query
            try db.run(user.update(name <- nameValue, email <- emailValue, age <- ageValue))
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Delete user
    public func deleteUser(idValue: Int64) {
        do {
            let user: Table =  users.filter(id == idValue)
            
            try db.run(user.delete())
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
