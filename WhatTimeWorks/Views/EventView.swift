//
//  EventView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/30/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

enum ActiveSheet {
    case first, second
}

struct EventView: View {
    
    @ObservedObject var planner: Planner
    
    var event: [String: Any]
    
    @State var showSheet = false
    @State var activeSheet : ActiveSheet = .first
//    @State var showResponses = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Colors.funkyBlue)
            
            HStack{
                VStack{
                    HStack{
    //                    Spacer()
                        
                        Text(self.event["name"] as! String)
                            .bold()
                        
    //                    Spacer()
                    }
                    
                    Text(self.event["owner"] as! String)
                }
                    .padding()
                    .shadow(radius: 1.0)
                
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .onTapGesture {
                        self.showSheet = true
                        self.activeSheet = .first
                    }
                
                Image(systemName: "envelope.badge.fill")
                    .onTapGesture {
                        self.showSheet = true
                        self.activeSheet = .second
                    }
            }
        }
            .sheet(isPresented: self.$showSheet, content: {
                if self.activeSheet == .first {
                    ShareView(id: self.event["id"] as? String ?? "")
                } else {
                    ResponsesView(event: self.event, id: self.event["id"] as? String ?? "")
                }
                
            })
            .padding()
    }
}
