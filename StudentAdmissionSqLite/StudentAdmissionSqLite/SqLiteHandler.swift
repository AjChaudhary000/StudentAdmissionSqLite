//
//  SqLiteHandler.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import SQLite3
class SqLiteHandler {
    static let shared = SqLiteHandler()
    let dbpath =  "StudentAdmission.sqlite"
    var db:OpaquePointer?
    private init(){
        db = OpenDataBase()
        CreateTable_StudentDetails()
        CreateTable_Notice()
    }
    func OpenDataBase() -> OpaquePointer? {
        let DocURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = DocURL.appendingPathComponent(dbpath)
        
        var database:OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK {
            print("Opened Connection to the database successfuly at \(fileURL)")
            return database
        }else{
            print("error connecting to the database.....")
            return nil
        }
    }
    func CreateTable_StudentDetails(){
            let String_Student = """
            CREATE TABLE IF NOT EXISTS STUDENT(
            SID INTEGER PRIMARY KEY AUTOINCREMENT,
            S_TYPE TEXT,
            S_NAME TEXT,
            PASSWORD TEXT,
            MOBILE_NO INTEGER,
            ADDRESS TEXT);
            """
        var createTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, String_Student, -1, &createTableStatment, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatment) == SQLITE_DONE{
                print("Student Table Created Successfuly..")
            }else{
                print("Student Table Could Not be Created ...")
            }
        }else{
            print("Create Table Statment Could not Be Prepared...")
        }
        sqlite3_finalize(createTableStatment)
    }
    func CreateTable_Notice(){
        let String_Student = """
            CREATE TABLE IF NOT EXISTS NOTICE(
            NID INTEGER PRIMARY KEY AUTOINCREMENT,
            N_NAME TEXT,
            N_DETAIL TEXT);
            """
        var createTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, String_Student, -1, &createTableStatment, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatment) == SQLITE_DONE{
                print("Student NOTICE Table Created Successfuly..")
            }else{
                print("Student NOTICE Table Could Not be Created ...")
            }
        }else{
            print("Create NOTICE Table Statment Could not Be Prepared...")
        }
        sqlite3_finalize(createTableStatment)
    }
    func Insert_Student(stud:Student)->Int{
        let Insert_Stud = """
        INSERT INTO STUDENT
        (S_TYPE,S_NAME,PASSWORD,MOBILE_NO,ADDRESS)
        VALUES (?,?,?,?,?);
        """
        
        var insertTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Insert_Stud, -1, &insertTableStatment, nil) == SQLITE_OK {
            sqlite3_bind_text(insertTableStatment, 1, (stud.s_type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertTableStatment, 2, (stud.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertTableStatment, 3, (stud.password as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertTableStatment, 4, Int32(stud.mobileno))
            sqlite3_bind_text(insertTableStatment, 5, (stud.address as NSString).utf8String, -1, nil)
            if sqlite3_step(insertTableStatment) == SQLITE_DONE{
                print("Student Data Add Successfuly..")
                return 0
            }else{
                print("Student Data Add not Insert ...")
                return 1
            }
        
        }else{
            print("Insert Table Statment Could not Be Prepared...")
            return 1
        }
        
    }
    func Insert_NOTICE(not:Notice)->Int{
        let Insert_Stud = """
        INSERT INTO NOTICE
        (N_NAME,N_DETAIL)
        VALUES (?,?);
        """
        
        var insertTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Insert_Stud, -1, &insertTableStatment, nil) == SQLITE_OK {
            sqlite3_bind_text(insertTableStatment, 1, (not.nname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertTableStatment, 2, (not.ndetail as NSString).utf8String, -1, nil)
            if sqlite3_step(insertTableStatment) == SQLITE_DONE{
                print("Student Data Add Successfuly..")
                return 0
            }else{
                print("Student Data Add not Insert ...")
                return 1
            }
            
        }else{
            print("Insert Table Statment Could not Be Prepared...")
            return 1
        }
        
    }
    func Update_Student(stud:Student)->Int{
        let Update_Stud = """
         UPDATE STUDENT SET S_TYPE = ? , S_NAME = ? , PASSWORD = ? , MOBILE_NO = ? , ADDRESS = ? WHERE SID = ? ;
        """
        
        var updateStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Update_Stud, -1, &updateStatment, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatment, 1, (stud.s_type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatment, 2, (stud.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatment, 3, (stud.password as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatment, 4, Int32(stud.mobileno))
            sqlite3_bind_text(updateStatment, 5, (stud.address as NSString).utf8String, -1, nil)
            if sqlite3_step(updateStatment) == SQLITE_DONE{
                print("Student Data Upadate Successfuly..")
                return 0
            }else{
                print("Student Data Update not Insert ...")
                return 1
            }
        }else{
            print("Update Table Statment Could not Be Prepared...")
            return 1
        }
       
    }
    func Select_Student(name:String,password:String)->[Student]{
        let Update_Stud = """
         SELECT * FROM STUDENT where S_NAME = ? AND PASSWORD = ?  ;
        """
        var stud = [Student]()
        var selectTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Update_Stud, -1, &selectTableStatment, nil) == SQLITE_OK {
            sqlite3_bind_text(selectTableStatment, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(selectTableStatment, 2, (password as NSString).utf8String, -1, nil)
            if sqlite3_step(selectTableStatment) == SQLITE_ROW {
                let sid = Int(sqlite3_column_int(selectTableStatment, 0))
                let type = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 1)))
                let name = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 2)))
                let password = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 3)))
                let mobileno = Int(sqlite3_column_int(selectTableStatment, 4))
                let address = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 5)))
                stud.append(Student(id: sid, s_type: type, name: name, password: password, mobileno:mobileno, address: address))
                print("\(stud)")
                print("Student Data Upadate Successfuly..")
            }else{
                print("Student Data Update not Insert ...")
            }
        }else{
            print("Select Table Statment Could not Be Prepared...")
        }
        return stud
    }
    func Select_Student_id(id:Int)->[Student]{
        let Update_Stud = """
         SELECT * FROM STUDENT where SID = ? ;
        """
        var stud = [Student]()
        var selectTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Update_Stud, -1, &selectTableStatment, nil) == SQLITE_OK {
            sqlite3_bind_int(selectTableStatment, 1, Int32(id))
           
            if sqlite3_step(selectTableStatment) == SQLITE_ROW {
                let sid = Int(sqlite3_column_int(selectTableStatment, 0))
                let type = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 1)))
                let name = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 2)))
                let password = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 3)))
                let mobileno = Int(sqlite3_column_int(selectTableStatment, 4))
                let address = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 5)))
                stud.append(Student(id: sid, s_type: type, name: name, password: password, mobileno:mobileno, address: address))
                print("\(stud)")
                print("Student Data Upadate Successfuly..")
            }else{
                print("Student Data Update not Insert ...")
            }
        }else{
            print("Select Table Statment Could not Be Prepared...")
        }
        return stud
    }
    func Select_Stud()->[Student]{
        let Update_Stud = "SELECT * FROM STUDENT ;"
        var stud  = [Student]()
        //var stud :[Student] = []
        var selectTableStatment1:OpaquePointer? = nil
        if sqlite3_prepare(db, Update_Stud, -1, &selectTableStatment1, nil) == SQLITE_OK {
            
            
            while sqlite3_step(selectTableStatment1) == SQLITE_ROW {
                let sid = Int(sqlite3_column_int(selectTableStatment1, 0))
                let type = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 1)))
                let name = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 2)))
                let password = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 3)))
                let mobileno = Int(sqlite3_column_int(selectTableStatment1, 4))
                let address = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 5)))
                stud.append(Student(id: sid, s_type: type, name: name, password: password, mobileno:mobileno, address: address))
               
                print("Student Data  Select Successfuly..")
            }
        }else{
            print("Select Table Statment Could not Be Prepared...")
        }
         sqlite3_finalize(selectTableStatment1)
        return stud
    }
    func Delete_Student_id(id:Int)-> Int {
        let Delete_Stud = "DELETE FROM STUDENT WHERE SID = ? ;"
        
        var DeletebleStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Delete_Stud, -1, &DeletebleStatment, nil) == SQLITE_OK {
            sqlite3_bind_int(DeletebleStatment, 1, Int32(id))
            
            if sqlite3_step(DeletebleStatment) == SQLITE_ROW {
               
                print("Student Data delete Successfuly..")
                return 0
            }else{
                print("Student Data Update not Insert ...")
                return 1
            }
        }else{
            print("Select Table Statment Could not Be Prepared...")
            return 1
        }
       }
    
    func Select_Notice_id(id:Int)->[Notice]{
        let Update_Stud = """
         SELECT * FROM NOTICE where NID = ? ;
        """
        var not = [Notice]()
        var selectTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Update_Stud, -1, &selectTableStatment, nil) == SQLITE_OK {
            sqlite3_bind_int(selectTableStatment, 1, Int32(id))
            
            if sqlite3_step(selectTableStatment) == SQLITE_ROW {
                let nid = Int(sqlite3_column_int(selectTableStatment, 0))
                let nname = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 1)))
                let ndetail = String(describing: String(cString: sqlite3_column_text(selectTableStatment, 2)))
                
                not.append(Notice(nid: nid, nname: nname, ndetail: ndetail))
                
                print("Student Data Upadate Successfuly..")
            }else{
                print("Student Data Update not Insert ...")
            }
        }else{
            print("Select Table Statment Could not Be Prepared...")
        }
        return not
    }
    func Select_Notice()->[Notice]{
        let Update_Stud = "SELECT * FROM NOTICE ;"
         var not = [Notice]()
        //var stud :[Student] = []
        var selectTableStatment1:OpaquePointer? = nil
        if sqlite3_prepare(db, Update_Stud, -1, &selectTableStatment1, nil) == SQLITE_OK {
            
            
            while sqlite3_step(selectTableStatment1) == SQLITE_ROW {
                let nid = Int(sqlite3_column_int(selectTableStatment1, 0))
                let nname = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 1)))
                let ndetail = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 2)))
                
                not.append(Notice(nid: nid, nname: nname, ndetail: ndetail))
                
                print("Student Data  Select Successfuly..")
            }
        }else{
            print("Select Table Statment Could not Be Prepared...")
        }
        sqlite3_finalize(selectTableStatment1)
        return not
    }
}


