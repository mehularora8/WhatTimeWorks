//
//  DashboardContainerView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/21/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct DashboardContainerView: View {
    
    @ObservedObject var planner: Planner
    
    @State var isLoggedIn = false
    
    var body: some View {
        Group {
            if !isLoggedIn {
                LoginPage(planner: self.planner, loggedIn: self.$isLoggedIn)
            } else {
                Dashboard(planner: self.planner)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
            }
        }
    }
}
