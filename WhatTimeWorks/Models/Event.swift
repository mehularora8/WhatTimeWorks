//
//  Event.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/14/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import Foundation

class Event {
    var name : String
    var owner: String // Owner's email
    var id : UUID
    var days : [Bool]
//    var availabilities: [Availability]
    var times: [Int]
    var timeVotes : [[UInt8]]
    
    init(name: String, times: [Int], days: [Bool], owner_email: String){
        self.name = name
        self.owner = owner_email
        self.id = UUID()
        self.days = days
//        self.availabilities = []
        self.times = times
        self.timeVotes = []
        
        for _ in 0 ..< days.filter({ $0 }).count {
            let hour_slots = ((self.times[1] - self.times[0]) / 100)
//            print(hour_slots)
            self.timeVotes.append([UInt8](repeating: 0, count: hour_slots))
//            print(self.timeVotes)
        }
    }
    
    init(name: String, times: [Int], id: UUID, days: [Bool], owner_email: String,
         timeVotes: [[UInt8]]){
        self.name = name
        self.owner = owner_email
        self.id = id
        self.days = days
//        self.availabilities = availabilities
        self.times = times
        self.timeVotes = timeVotes
    }
    
    func updateDay(dayNumber dayIndex: Int){
        
        if(dayIndex < 0 || dayIndex > 6) {
            return
        }
        
        self.days[dayIndex].toggle()
    }
    
    func toAnyObject() -> [String: Any]{
        return [
            "owner": self.owner,
            "days" : self.days,
//            "availabilities": [],
            "times": self.times,
            "id" : id.uuidString,
            "name": name,
            "timeVotes": self.timeVotes
        ]
    }
}
