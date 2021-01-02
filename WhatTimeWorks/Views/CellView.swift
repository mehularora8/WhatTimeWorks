//
//  CellView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 1/1/21.
//  Copyright © 2021 Mehul Arora. All rights reserved.
//

import SwiftUI

struct CellView: View {
    
    var index: Int
    var k: Int
    
    var timeVotes: [[UInt8]]
    var startTime: Int
    var endTime: Int
    
    var maxVotes: UInt8
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(Color.gray)
            
            RoundedRectangle(cornerRadius: 5.0)
                .fill(Colors.sunset)
                .opacity(Double(self.timeVotes[self.index][self.k]) / Double(self.maxVotes))
            
            VStack{
                Text("\(startTime + (100 * k)) - \(startTime + (100 * k) + 100)")
                    .padding()
                
                Text("\(self.timeVotes[index][k]) votes")
            }
                .foregroundColor(self.timeVotes[index][k] > 0 ? Color.white : Color.black)
                 
        }
            .padding()
    }
}
