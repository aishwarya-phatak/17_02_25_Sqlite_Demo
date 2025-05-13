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
        let createQueryString = "CREATE TABLE IF NOT EXISTS Student1(rollnumber INTEGER, name Text);"
        var createStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
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
    
    func insertStudentRecords(rN : Int, name : String){
        let insertQueryString = "INSERT INTO Student1(rollnumber,name) VALUES(?,?);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                           insertQueryString,
                           -1,
                           &insertStatement,
                           nil) == SQLITE_OK{
            print("insert statement query prepared successfully")
            
            sqlite3_bind_int(insertStatement, 1, Int32(rN))
        
            sqlite3_bind_text(insertStatement,
                              2,
                              (name as NSString).utf8String,
                              -1,
                              nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("insertion of student data is completed")
            } else {
                print("insertion of student data failed")
            }
        } else {
            print("insert statement query preparation is unsuccessful")
        }
        sqlite3_finalize(insertStatement)
    }

    
    func deleteStudentRecord(rn : Int){
        let deleteQueryString = "DELETE FROM Student1 where rollnumber = ?;"
        var deleteStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(db,
                              deleteQueryString,
                              -1,
                              &deleteStatement,
                              nil) == SQLITE_OK{
            print("delete statement preparation successful!")
            
            sqlite3_bind_int(deleteStatement, 1, Int32(rn))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("deletion successful!")
            } else {
                print("deletion unsuccessful!")
            }
        } else {
            print("delete statement preparation Falied!")
        }
        
        sqlite3_finalize(deleteStatement)
    }
    
    func retriveStudentRecords(){
        
    }
   
}
