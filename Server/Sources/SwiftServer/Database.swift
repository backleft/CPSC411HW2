import SQLite3
import Foundation

class Database {
    static var dbObj : Database!
    let dbName = "/Users/BackLeft/Backup_SwiftServer/claimsDb.sqlite"
    var conn : OpaquePointer!

    init() {
        // 1. create database
        if sqlite3_open(dbName, &conn) == SQLITE_OK {
            // create tables
            initializeDB()
            sqlite3_close(conn)
        } else {
            let errcode = sqlite3_errcode(conn)
            print("Open database failed due to error \(errcode)")
        }
    }

    private func initializeDB() {
        let sqlStmt = "create table if not exists Claims(claim_id,claim_title,claim_date,claim_isSolved)"
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let errcode = sqlite3_errcode(conn)
            print("Create table failed due to error \(errcode)")
        }
    }

    func getDBConn() -> OpaquePointer? {
        var conn : OpaquePointer?
        if sqlite3_open(dbName, &conn) == SQLITE_OK {
            return conn
        } else {
            let errcode = sqlite3_errcode(conn)
            let errmsg = sqlite3_errmsg(conn)
            print("Open database failed due to error \(errcode)")
            print("Open database failed due to error \(errmsg!)")
            let _ = String(format:"%@", errmsg!)
            //let len = strlen(errmsg)
            //let data = Data(bytes: errmsg!, count: len)
        }
        return conn
    }
    
    static func getInstance() -> Database {
        if dbObj == nil {
            dbObj = Database()
        }
        return dbObj
    }
}
/*

class Database {
    //Database Wrapper
    static var dbObj : Database!
    let dbName = "/Users/BackLeft/Backup_SwiftServer/PersonalDB.sqlite"
    //let dbName = "/Users/BackLeft/Backup_SwiftServer/ClaimsDB.sqlite"
    //let fileManager = FileManager.default.currentDirectoryPath
    //let dbName = "./ClaimsDB.sqlite"
    var conn : OpaquePointer?
    init() {
        //1. create db
        //2. create tables
        if sqlite3_open(dbName,&conn) == SQLITE_OK {
            initializeDB()
            sqlite3_close(conn)
        }
        else {
            let errcode = sqlite3_errcode(conn)
            print("Open database failed due to error \(errcode)")
        }
    }
    private func initializeDB(){
        let sqlSmt = "create table if not exists person (first_name, last_name, ssn)"
        if sqlite3_exec(conn, sqlSmt, nil, nil, nil) != SQLITE_OK {
            let errCode = sqlite3_errcode(conn)
            print("Create Table failed due to error \(errCode)")
        }
    }
    func getDBconn() -> OpaquePointer? {
        var conn : OpaquePointer?
        if sqlite3_open(dbName,&conn) == SQLITE_OK {
           return conn
        }
        else {
            //let errcode = sqlite3_errcode(conn)
            //print("Create Table filed due to error \(errcode)")
            let errcode = sqlite3_errcode(conn)
            let errmsg = sqlite3_errmsg(conn)
            print("Open database failed due to error \(errcode)")
            print("Open database failed due to error \(errmsg!)")
            let _ = String(format:"%@", errmsg!)
        }
        return conn
    }
    static func getInstance() -> Database{
        if dbObj == nil{
            dbObj = Database()
        }
        return dbObj
    }
}
*/
