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
 - Fix dark mode on responses
 - Move functions to Viewmodel
 - Allow users to delete events
 - remove copy view and copy in place
 */

import SwiftUI
import Firebase

struct EventResponse: View {
    
    @ObservedObject var planner: Planner
    
    @State var eventID: String = ""
    @State var eventFound: Bool = false
    
    @State var snap: [String: Any] = [String : Any]()
    @State var times: [Int] = []
    @State var availableDays: [Bool] = []
    
    var availableIndices: [Int] {
        self.availableDays.enumerated().compactMap({ $1 ? $0 : nil})
    }
    
    @State var hourSlots: Int = 2
    
    @State var previousTimeVotes = [[UInt8]]()
    @State var chosenTimes = [[UInt8]]()
    
    @State var invalidID = false
    @State var showHelp = false
    
    var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Colors.matteBlack)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                if !self.eventFound{
                    Text("Respond to an event")
                        .font(.system(size: 35, weight: .semibold, design: .rounded))
                        .padding(.vertical)
                    
                    HStack(alignment: .center) {
                        Text("Event ID:")
                        Spacer()
                    }
                        .padding(.vertical)
                    
                    HStack {
                        TextField("Event ID", text: self.$eventID)
                            .disableAutocorrection(true)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3.0)
                                    .stroke(Colors.lightGray)
                                    .padding(-7)
                            )
                            .background(Colors.matteBlack)
                            .padding()
                        
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(Color.pink)
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
                        self.fetchEventData()
                    }, label: {
                        Text("Get event")
                            .bold()
                            .buttonify()
                    })
                }
                
                if self.eventFound {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.availableIndices.enumerated().sorted(by: >), id: \.0){ (index, n) in
                                VStack{
                                    // MARK: abstract this into CellView
                                    // MARK: TODO: Don't allow users to rsvp twice.
                                    
                                    Text(self.days[n])
                                    
                                    ForEach(0 ..< self.hourSlots, id: \.self){ k in
                                        EventResponseVoteCellView(index: index, k: k,
                                                                  chosenTimes: self.chosenTimes, startTime: self.times[0])
                                            .padding()
                                            .onTapGesture {
                                                if self.chosenTimes[index][k] == 0 {
                                                    self.chosenTimes[index][k] = 1
                                                } else {
                                                    self.chosenTimes[index][k] = 0
                                                }
                                            }
                                    }
                                }
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                        }
                    }
                    
                    Button(action: {
                        self.respondToEvent()
                        
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
                .foregroundColor(Color.white)
                .alert(isPresented: self.$invalidID, content: {
                    Alert(title: Text("Invalid event ID"), message: Text("We could not find this event. Please contact the owner of this event."), dismissButton: .default(Text("OK")))
                })
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .padding()
        }
    }
    
    private func fetchEventData() {
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
            
            self.previousTimeVotes = self.snap["timeVotes"] as? [[UInt8]] ?? [[UInt8]]()
            
            for _ in 0 ..< self.previousTimeVotes.count {
                self.chosenTimes.append([UInt8](repeating: 0, count: self.hourSlots))
            }
            
            self.eventFound = true
        })
    }
    
    private func respondToEvent() {
        if self.eventID == "" {
            return
        }
        
        let newVotes = zip(self.previousTimeVotes, self.chosenTimes).map() { zip($0, $1).map(+) }
        
        let e = Event(
                    name: self.snap["name"] as? String ?? "",
                    times: self.times,
                    id: UUID(uuidString: self.snap["id"] as? String ?? "") ?? UUID(),
                    days: self.availableDays,
                    owner_email: self.snap["owner"] as? String ?? "",
                    timeVotes: newVotes
                )
        
        self.planner.eventRef.child(self.eventID).setValue(e.toAnyObject())
    }
}

struct EventResponseVoteCellView: View {
    
    var index: Int
    var k : Int
    
    var chosenTimes: [[UInt8]]
    var startTime: Int
    
    var colored : Bool {
        self.chosenTimes[self.index][self.k] == 1
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5.0)
                .fill(self.colored ? Colors.brightYellow : Colors.lightGray)
            
            Text("\(self.startTime + (100 * k)) - \(self.startTime + (100 * k) + 100)")
                .foregroundColor(self.chosenTimes[index][k] == 1 ? Color.white : Color.black)
                .padding()
        }
    }
}
