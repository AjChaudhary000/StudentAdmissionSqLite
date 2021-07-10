//
//  Notice.swift
//  StudentAdmissionSqLite
//
//  Created by DCS on 09/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class Notice {
    var nid:Int = 0
    var nname:String = ""
    var ndetail:String = ""
     init(nid:Int,nname:String,ndetail:String)
    {
     self.nid = nid
        self.nname = nname
        self.ndetail = ndetail
        
    }
    
}
