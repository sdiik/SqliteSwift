//
//  DBHelper.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 03/02/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {
   
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
            create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error open database")
            return nil
        } else {
            print("successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY, name TEXT, age INTEGER)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    func insert(idPerson: Int, namePerson: String, agePerson: Int) {
        let persons = read()
        for p in persons {
            if p.id == idPerson {
                return
            }
        }
        let insertStatementString = "INSERT INTO person (id, name, age) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(idPerson))
            sqlite3_bind_text(insertStatement, 2, (namePerson as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(agePerson))
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person"
        var queryStatement: OpaquePointer? = nil
        var persons: [Person] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let years = sqlite3_column_int(queryStatement, 2)
                persons.append(Person(id: Int(id), name: name, age: Int(years)))
            }
            print(persons.count)
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return persons
    }
    func deleteById(idPerson: Int) {
        let deleteStatementString = "DELETE FROM person WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(idPerson))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully delete row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    init() {
        db = openDatabase()
        createTable()
    }
}

