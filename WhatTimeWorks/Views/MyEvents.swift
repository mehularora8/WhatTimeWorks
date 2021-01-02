//
//  MyEvents.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/21/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct MyEvents: View {
    
    @ObservedObject var planner: Planner
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Colors.matteBlack)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                    Text("My events")
                        .font(.system(size: 35, weight: .semibold, design: .rounded))
                        .padding(.vertical)
                    
                    ForEach(0 ..< self.planner.userEvents.count, id: \.self){ n in
                        EventView(planner: self.planner, event: self.planner.userEvents[n])
                    }
            }
                .navigationBarHidden(true)
                .foregroundColor(.white)
        }
//            .navigationBarTitle("")
    }
}
