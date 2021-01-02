//
//  ResponsesView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/30/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct ResponsesView: View {
    
    var event: [String: Any]
    var id: String
    
    @State var availableDays: [Bool] = []
    
    var availableIndices: [Int] {
        self.availableDays.enumerated().compactMap({ $1 ? $0 : nil})
    }
    
    @State var timeVotes: [[UInt8]] = []
    
    @State var times: [Int] = []
    
    @State var maxVotes: UInt8 = 1
    
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(self.availableIndices.enumerated().sorted(by: >), id: \.0){ (index, n) in
                    VStack{
                        Text(self.days[n])
                        
                        ForEach(0 ..< (self.times[1] - self.times[0]) / 100, id: \.self){ k in
                            CellView(index: index, k: k, timeVotes: self.timeVotes,
                                     startTime: self.times[0], endTime: self.times[1],
                                     maxVotes: self.maxVotes)
                        }
                    }
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
            .padding()
            .onAppear(perform: {
                self.extractInformationFromEvent()
            })
    }
    
    private func extractInformationFromEvent() {
        self.availableDays = self.event["days"] as? [Bool] ?? [Bool]()
        self.times = self.event["times"] as? [Int] ?? [300, 400]
        let t = self.event["timeVotes"] as? [[UInt8]] ?? [[UInt8]]()
        self.timeVotes = t
        self.maxVotes = t.map({ $0.max() ?? 1 }).max() ?? 1
        if self.maxVotes == 0 {
            self.maxVotes += 1
        }
    }
}

