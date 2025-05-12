//
//  DBHelper.swift
//  17_02_25_Sqlite_Demo
//
//  Created by Vishal Jagtap on 09/05/25.
//

import Foundation
import SQLite3

final class DBHelper{
    
    static let shared = DBHelper()
    var dbPath = "dbtest.sqlite"
    var db : OpaquePointer?
    
    init(){
        db = createDatabase()
        createTable()
    }
    
    func createDatabase() -> OpaquePointer?{
        var file = try! FileManager.default.url(
                                       for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false
        ).appendingPathComponent(dbPath)
        
        if sqlite3_open(file.path, &db) == SQLITE_OK{
            print("database created successfully")
            print("database details ----- \(file.relativePath) \(file.pathComponents)--")
        } else {
            print("database creation falied")
        }
        return db
    }
    
    func createTable(){
        let createQueryString = "CREATE TABLE IF NOT EXISTS Student(rollNumber INTEGER, name Text);"
        var createStatement : OpaquePointer?
        
        if sqlite3_prepare(db,
                           createQueryString,
                           -1,
                           &createStatement,
                           nil) == SQLITE_OK{
            print("Student table creation successful!")
        } else {
            print("Student table creation unsuccesful!")
        }
        sqlite3_finalize(createStatement)
    }
}
