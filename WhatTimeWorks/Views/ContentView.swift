//
//  ContentView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/12/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct AddEvent: View {
    
    @ObservedObject planner: Planner
    
    var body: some View {
        Button(action: {
            self.planner.addEvent()
        }, label: {
            Text("Add event")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddEvent()
    }
}
