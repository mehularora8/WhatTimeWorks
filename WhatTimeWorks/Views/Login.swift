//
//  LoginPage.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/14/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    
    @ObservedObject var planner: Planner
    
    @State var email = ""
    @State var password = ""
    @State var signInFailed = false
    
    // Bind to view calling it to display
    @Binding var loggedIn : Bool
    
    var body: some View {
        GeometryReader{ geo in
            
            ZStack{
                Rectangle()
                    .fill(Color.white)
    //                .fill(royalBlue)
                
                VStack{
                    Text("WhatTimeWorks?")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding()
                        .foregroundColor(Colors.royalBlue)
    //                    .foregroundColor(.white)
                    
                    HStack{
                        Text("Sign in")
                            .padding(.leading)
                            .padding(.trailing)
                            .padding(.top)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                        
                        Spacer()
                    }
                    
                    TextField("Username", text: self.$email)
                        .disableAutocorrection(true)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: geo.size.height * 0.1)
                    
                    SecureField("Password", text: self.$password)
                        .disableAutocorrection(true)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: geo.size.height * 0.1)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 2.0)
                            .fill(Colors.royalBlue)
                            .frame(maxWidth: geo.size.width / 3, maxHeight: geo.size.height / 15)
                        
                        Text("Sign in")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .onTapGesture {
                                if self.email == "" || self.password == "" {
                                    return
                                }
                                
                                Auth.auth().signIn(withEmail: self.email, password: self.password, completion: { user, error in
                                    if let _ = error, user == nil {
                                        self.signInFailed = true
                                    }
                                })
                            }
                        
                    }
                        .padding()
                }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    Auth.auth().addStateDidChangeListener({ auth, user in
                        if user != nil {
                            self.loggedIn = true
                            self.planner.user = user
                        }
                    })
                })
                .alert(isPresented: self.$signInFailed, content: {
                    Alert(title: Text("Sign in failed"), message: Text("We could not sign you in"), dismissButton: .default(Text("OK")))
                })
        }
    }
}
