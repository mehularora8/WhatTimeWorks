//
//  LoginPage.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/14/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct LandingPage: View {
    
    @ObservedObject var planner: Planner
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        GeometryReader{ geo in
            
            NavigationView{
            
                ZStack{
                    Rectangle()
                        .fill(Colors.matteBlack)
                    
                    VStack{
                        Spacer()
                        
                        Text("WhatTimeWorks?")
                            .foregroundColor(Color.white)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .padding()
                        
                        Text("All you need to manage your events.")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        NavigationLink(destination: DashboardContainerView(planner: self.planner), label: {
                            Text("Sign in")
                                .bold()
                                .buttonify()
                        })
                        
                        HStack {
                            Spacer()
                            
                            Text("Don't have an account? ")
                                .foregroundColor(.white)
                            
                            NavigationLink(destination: Signup(), label: {
                                Text("Sign up")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.semibold)
                            })
                            
                            Spacer()
                        }
                            .padding()
                    }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
