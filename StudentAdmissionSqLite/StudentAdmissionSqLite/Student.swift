//
//  Student.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class Student {
    var sid:Int  = 0
    var s_type:String =  ""
    var name:String = ""
    var password:String = ""
    var mobileno:Int = 0
    var address:String = ""
    init(id:Int,s_type:String,name:String,password:String,mobileno:Int,address:String) {
        self.sid    = id
        self.s_type = s_type
        self.name = name
        self.password = password
        self.mobileno  = mobileno
        self.address = address
    }
}
