//
//  Availability.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/22/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import Foundation

class Availability {
    var user: String
    var times: (Int, Int)
    
    init(email: String, times: (Int, Int)) {
        self.user = email
        self.times = times
    }
}
