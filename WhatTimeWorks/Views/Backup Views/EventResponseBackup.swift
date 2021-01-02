//
//  EventResponseBackup.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 1/1/21.
//  Copyright © 2021 Mehul Arora. All rights reserved.
//

import SwiftUI

//
//  EventResponse.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/21/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

// MARK: TODO:
/*
 Showing users who responded to which events and on what times
 Make UI nicer
 Show how many votes were on this time slot
 Allow users to exit out of the RSVP.
 - Fix dark mode on responses
 - in EventResponse use the enumerated technique, makes life much easier.
 - See if you can fix the "What's the occasion" thing and get rid of "Name of event" in AddEvent. Otherwise AddEvent is done.
 - Fix landing page, make prettier.
 - First page should be AddEvent.
 - Break event responses page.
 */

import SwiftUI
import Firebase

struct EventResponseBackup: View {
    
    @ObservedObject var planner: Planner
    
    @State var eventID: String = ""
    @State var eventFound: Bool = false
    
    @State var snap: [String: Any] = [String : Any]()
    @State var times: [Int] = []
    @State var availableDays: [Bool] = []
    @State var availableIndices: [Int] = []
    @State var hourSlots: Int = 2
    
    @State var previousTimeVotes = [[UInt8]]()
    @State var chosenTimes = [[UInt8]]()
    
    @State var invalidID = false
    @State var showHelp = false
    
    var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if !self.eventFound{
                Text("Respond to an event")
                    .font(.system(size: 35, weight: .semibold, design: .rounded))
                    .padding(.vertical)
                
                HStack {
                    TextField("Event ID", text: self.$eventID)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.purple)
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.showHelp.toggle()
                            }
                        }
                }
                
                if self.showHelp {
                    Text("Each event is created with a corresponding event ID. Please ask the owner of the event to share that ID with you.")
                        .foregroundColor(Colors.lightGray)
                }
                
                Button(action: {
                    // Fetch the event
                    guard let _ = self.planner.user?.email else { return }
                    
                    self.planner.eventRef.child(self.eventID).observeSingleEvent(of: .value, with: { snapshot in
                        
                        self.snap = snapshot.value as? [String : Any] ?? [String: Any]()
                        
                        if self.snap["id"] == nil {
                            self.invalidID = true
                            return
                        }
                        
                        let t = self.snap["times"] as? [Int] ?? [Int]()
                        self.times = t
                        self.hourSlots = (t[1] - t[0]) / 100
                        
                        self.availableDays = self.snap["days"] as? [Bool] ?? [Bool]()
                        
                        for i in 0 ..< self.availableDays.count {
                            if self.availableDays[i] {
                                self.availableIndices.append(i)
                            }
                        }
                        
                        self.previousTimeVotes = self.snap["timeVotes"] as? [[UInt8]] ?? [[UInt8]]()
                        
                        for _ in 0 ..< self.previousTimeVotes.count {
                            self.chosenTimes.append([UInt8](repeating: 0, count: self.hourSlots))
                        }
                        
                        self.eventFound = true
                    })
                    
                }, label: {
                    Text("Get event")
                        .bold()
                        .buttonify()
                })
            }
            
            if self.eventFound {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0 ..< 7, id: \.self){ n in
                            VStack{
                                if self.availableDays[n] {
                                    Text(self.days[n])
                                    
                                    ForEach(0 ..< self.hourSlots, id: \.self){ k in
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5.0)
                                                .stroke(Colors.lightGray)
                                            
                                            RoundedRectangle(cornerRadius: 5.0)
                                                .fill(self.chosenTimes[self.availableIndices.firstIndex(of: n) ?? 0][k] == 1 ? Color.green : Color.white)
                                            
                                            Text("\(self.times[0] + (100 * k)) - \(self.times[0] + (100 * k) + 100)")
                                                .padding()
                                        }
                                            .padding()
                                            .onTapGesture {
                                                let index = self.availableIndices.firstIndex(of: n)!
                                                if self.chosenTimes[index][k] == 0 {
                                                    self.chosenTimes[index][k] = 1
                                                } else {
                                                    self.chosenTimes[index][k] = 0
                                                }
                                                
                                            }
                                        
                                        // MARK: TODO: Don't allow users to rsvp twice.
                                    }
                                }
                            }
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                }
                
                Button(action: {
                    if self.eventID == "" {
                        return
                    }
                    
                    let newVotes = zip(self.previousTimeVotes, self.chosenTimes).map() { zip($0, $1).map(+) }
                    let e = Event(name: self.snap["name"] as? String ?? "", times: self.times, id: UUID(uuidString: self.snap["id"] as? String ?? "") ?? UUID(), days: self.availableDays, owner_email: self.snap["owner"] as? String ?? "", timeVotes: newVotes)
                    
                    self.planner.eventRef.child(self.eventID).setValue(e.toAnyObject())
                    
                }, label: {
                    Text("RSVP!")
                        .bold()
                        .buttonify()
                })
                
                Button(action: {
                    self.eventID = ""
                    self.eventFound = false
                    
                }, label: {
                    Text("Exit")
                        .bold()
                        .buttonify()
                })
            }
        }
            .alert(isPresented: self.$invalidID, content: {
                Alert(title: Text("Invalid event ID"), message: Text("We could not find this event. Please contact the owner of this event."), dismissButton: .default(Text("OK")))
            })
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .padding(.vertical)
    }
}
