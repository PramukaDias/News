//
//  NUser.swift
//  PNews
//
//  Created by Pramuka Dias on 1/20/20.
//  Copyright © 2020 Pramuka Dias. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class NUser: Object{
    
    dynamic var fullname: String = ""
    dynamic var username: String = ""
    dynamic var email: String = ""
    dynamic var password: String = ""
    
    convenience init(fullname: String, username: String, email: String, password: String){
        self.init()
        self.fullname = fullname
        self.username = username
        self.email = email
        self.password = password
    }
}
