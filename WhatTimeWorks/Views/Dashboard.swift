//
//  Dashboard.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/14/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI
import Firebase

struct Dashboard: View {
    
    var planner: Planner
    
    var body: some View {
        
        TabView() {
            MyEvents(planner: self.planner)
                .tabItem({
                    TabItemView(text: "My Events", img: Image(systemName: "person.fill"))
                })
            
            AddEvent(planner: self.planner)
                .tabItem({
                    TabItemView(text: "Add Event", img: Image(systemName: "plus"))
                })
            
            EventResponse(planner: self.planner) 
                .tabItem({
                    TabItemView(text: "RSVP", img: Image(systemName: "checkmark"))
                })
        }
            .accentColor(.white)
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                UITabBar.appearance().barTintColor = Colors.UIMatteBlack
                self.fetchUserEventData()
            })
    }
    
    private func fetchUserEventData() {
        self.planner.eventRef.observe(.value){ snapshot in
            if !snapshot.exists() {
                return
            }
            
            var newEvents = [[String: Any]]()
            
            for child in snapshot.children {
                
                if let s = child as? DataSnapshot {
                    let ssValue = s.value as! [String: Any]
                    
                    if ssValue["owner"] as? String ?? "" == String(self.planner.user?.email ?? "") {
                        newEvents.append(ssValue)
                    }
                }
                
                self.planner.userEvents = newEvents
            }
        }
    }
}
