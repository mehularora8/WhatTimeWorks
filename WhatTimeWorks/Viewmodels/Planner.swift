//
//  Planner.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/13/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI
import Firebase

class Planner: ObservableObject {
    
    let eventRef: DatabaseReference
    var user: FirebaseAuth.User?
    @Published var userEvents: [[String: Any]]
    
    init(){
        self.eventRef = Database.database().reference(withPath: "events")
        self.user = nil
        self.userEvents = []
    }
}
