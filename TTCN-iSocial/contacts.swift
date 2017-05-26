//
//  contacts.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/19/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation

struct contacts {
    let name: String
    let job : String
    let mail: String
    let phone: String
    let avatar: String
    
    init(dic: [String:String]) {
        self.name   = dic   ["name"]     ?? ""
        self.job    = dic   ["job"]      ?? ""
        self.mail   = dic   ["mail"]     ?? ""
        self.phone  = dic   ["phone"]    ?? ""
        self.avatar = dic   ["avatar"]   ?? ""
    }
}
