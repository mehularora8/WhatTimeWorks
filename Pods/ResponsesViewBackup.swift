//
//  ResponsesViewBackup.swift
//  FirebaseAuth
//
//  Created by Mehul Arora on 12/31/20.
//

import SwiftUI

struct ResponsesViewBackup: View {
    
    var event: [String: Any]
    var id: String
    
    var availableDays: [Bool] {
        self.event["days"] as? [Bool] ?? [Bool]()
    }
    
    var availableIndices: [Int] {
        self.availableDays.enumerated().compactMap({ $1 ? $0 : nil })
    }
    
    var timeVotes: [[UInt8]] {
        self.event["timeVotes"] as? [[UInt8]] ?? [[UInt8]]()
    }
    
    var times: [Int] {
        self.event["times"] as? [Int] ?? [300, 400]
    }
    
    @State var maxVotes: UInt8 = 1
    
    var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(0 ..< 7, id: \.self){ n in
                    VStack{
                        if self.availableDays[n] {
                            Text(self.days[n])
//
                            ForEach(0 ..< (self.times[1] - self.times[0]) / 100, id: \.self){ k in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5.0)
                                        .stroke(Color.gray)
//
                                    Group {
                                        if self.availableIndices.firstIndex(of: n) != nil {
                                            RoundedRectangle(cornerRadius: 5.0)
                                                .fill(self.timeVotes[self.availableIndices.firstIndex(of: n)!][k] > 0 ? Color.blue : Color.white)
                                                .opacity(Double(self.timeVotes[self.availableIndices.firstIndex(of: n)!][k]) / Double(self.maxVotes))
                                            
                                            VStack{
                                                Text("\(String(self.times[0] + (100 * k))) - \(String(self.times[0] + (100 * k) + 100))")
                                                    .padding()
                                                
                                                Text("\(self.timeVotes[self.availableIndices.firstIndex(of: n)!][k]) votes")
                                            }
//                                                .foregroundColor(self.timeVotes[self.availableIndices.firstIndex(of: n)!][k] > 0 ? Color.white : Color.black)
                                        }
                                    }
//
                                    
                                }
                                    .padding()
                            }
                        }
                    }
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
            .onAppear(perform: {
                self.maxVotes = self.timeVotes.map({ $0.max() ?? 1}).max() ?? 1
            })
    }
}

