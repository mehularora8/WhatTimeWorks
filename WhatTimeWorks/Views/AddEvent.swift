//
//  ContentView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/12/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct AddEvent: View {
    
    @ObservedObject var planner: Planner
    @State var eventName = ""
    @State var eventDays = ["M", "T", "W", "Th", "F", "Sa", "S"]
    @State var selectedDays = [false, false, false, false, false, false, false]
    
    @State var startTime: Int = 4
    @State var endTime: Int = 5
    @State var startTimePM = false
    @State var endTimePM = false
    
    var periods = ["AM", "PM"]
    var startTimes = [0000, 0100, 0200, 0300, 0400, 0500, 0600, 0700, 0800,
                      0900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700,
                      1800, 1900, 2000, 2100, 2200, 2300]
    
    @State var errorCreatingEvent: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Colors.matteBlack)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                Text("NEW EVENT")
                    .font(.system(size: 35, weight: .semibold, design: .rounded))
                    .padding(.vertical)
                
                Group {
                    HStack{
                        Text("Event Name:")
                        Spacer()
                    }
                    
                    TextField("", text: $eventName)
                        .disableAutocorrection(true)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3.0)
                                .stroke(Colors.lightGray)
                                .padding(-7)
                        )
                        .background(Colors.matteBlack)
                        .padding()
                    
                }
                
                HStack{
                    ForEach(self.eventDays, id: \.self){ day in
                        ZStack{
                            Circle()
                                .fill(self.selectedDays[self.eventDays.firstIndex(of: day) ?? 0] ? Colors.midnightBlue : Colors.lightGray)
                                
                            
                            Text(day)
                                .foregroundColor(self.selectedDays[self.eventDays.firstIndex(of: day) ?? 0] ? Color.white : Colors.darkGray)
                        }
                            .onTapGesture {
                                let index = self.eventDays.firstIndex(of: day) ?? 0
                                self.selectedDays[index].toggle()
                            }
                    }
                }
                    .frame(minHeight: 70)
                
                HStack{
                    Text("From:")
                    Spacer()
                }
                
                // MARK: TODO: Make sure that start time is earlier than end time.
                
                HStack{
                    Spacer()
                    
                    Text("\(self.startTime)")
                    
                    Stepper("", onIncrement: {
                        
                        if self.startTime >= 12 {
                            return
                        }
                        self.startTime += 1
                    }, onDecrement: {
                        if self.startTime <= 1{
                            return
                        }
                        self.startTime -= 1
                    })
                        .labelsHidden()
                        .background(Colors.lightGray)
                    
                    Spacer()
                    
                    if !self.startTimePM {
                        Text("AM")
                            .bold()
                    } else {
                        Text("AM")
                    }
                    
                    Toggle("", isOn: $startTimePM)
                        .labelsHidden()
                        .toggleStyle(NoLabelColoredToggleStyle())
                        .accentColor(Colors.royalBlue)
                        
                    if self.startTimePM {
                        Text("PM")
                            .bold()
                    } else {
                        Text("PM")
                    }
                    Spacer()
                }
                    .padding(.bottom)
                
                HStack{
                    Text("To:")
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    
                    Text("\(self.endTime)")
                    Stepper("", onIncrement: {
                        if self.endTime >= 12 {
                            return
                        }
                        self.endTime += 1
                    }, onDecrement: {
                        if self.endTime <= 1 {
                            return
                        }
                        self.endTime -= 1
                    })
                        .labelsHidden()
                        .background(Colors.lightGray)
                    
                    Spacer()
                    
                    if !self.endTimePM {
                        Text("AM")
                            .bold()
                    } else {
                        Text("AM")
                    }
                    
                    Toggle("", isOn: self.$endTimePM)
                        .labelsHidden()
                        .toggleStyle(NoLabelColoredToggleStyle())
                    
                    if self.endTimePM {
                        Text("PM")
                            .bold()
                    } else {
                        Text("PM")
                    }
                    
                    Spacer()
                }
                
                
                Button(action: {
                    self.createEvent()
                    // Reset event state after creating.
                    self.resetState()
                    
                }, label: {
                            
                    Text("Create Event")
                        .bold()
                        .buttonify()
                })
                
                Button(action: {
                    self.resetState()
                    
                }, label: {
                    Text("Start Over")
                        .bold()
                        .buttonify()
                })
            }
                .foregroundColor(Color.white)
                .alert(isPresented: self.$errorCreatingEvent, content: {
                    Alert(title: Text("Error creating event"), message: Text("Please make sure you have a name and have selected days for your event"), dismissButton: .default(Text("OK")))
                })
                .padding()
                .navigationBarHidden(true)
                .navigationBarTitle("")
        }
    }
    
    private func resetState() {
        self.eventName = ""
        self.selectedDays = [Bool](repeating: false, count: 7)
        self.startTime = 4
        self.endTime = 5
        self.startTimePM = false
        self.endTimePM = false
    }
    
    private func createEvent() {
        if self.eventName == "" {
            self.errorCreatingEvent = true
            return
        }
        
        if self.selectedDays.allSatisfy({x in x == false }){
            self.errorCreatingEvent = true
            return
        }
        
        let st = self.startTimePM ? (self.startTime + 12) * 100 : (self.startTime) * 100
        let et = self.endTimePM ? (self.endTime + 12) * 100 : (self.endTime) * 100
        let e = Event(name: self.eventName, times: [st, et], days: self.selectedDays, owner_email: self.planner.user?.email ?? "")
        
        let r = self.planner.eventRef.child(e.id.uuidString)
        r.setValue(e.toAnyObject())
    }
}


struct AddEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddEvent(planner: Planner())
    }
}
