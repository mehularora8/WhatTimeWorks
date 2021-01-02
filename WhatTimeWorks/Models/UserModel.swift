//
//  UserModel.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/12/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import Foundation

class User {
    var uuid: String
    var email: String
    var displayName: String?
    var events: [Event]
    
    init(id: String, email: String, displayName: String?) {
        self.uuid = id
        self.email = email
        self.displayName = displayName
        self.events = []
    }
    
    func toAnyObject() -> Any {
        return [
            "email" : email,
            "displayName": displayName
        ]
    }
}
