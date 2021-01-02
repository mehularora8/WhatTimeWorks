//
//  Signup.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/14/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

//
//  LoginPage.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/14/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct Signup: View {
    
    @State var email = ""
    @State var password = ""
    
    @State var failedToSignUp = false
    @State var successfulSignUp = false
    
    @State var status : Error? = nil
    
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
                        Text("Sign up")
                            .padding(.leading)
                            .padding(.trailing)
                            .padding(.top)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                        
                        Spacer()
                    }
                    
                    TextField("Email", text: self.$email)
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
                        
                        HStack{
                            Text("Sign up")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .onTapGesture {
                                    Auth.auth().createUser(withEmail: self.email, password: self.password, completion: {user, error in
                                        if error != nil {
                                            self.failedToSignUp = true
                                            self.status = error
                                        } else{
                                            self.successfulSignUp = true
                                        }
                                    })
                                }
                        }
                        
                    }
                        .padding()
                }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                .edgesIgnoringSafeArea(.all)
                .alert(isPresented: self.$failedToSignUp, content: {
                    Alert(title: Text("Failed to sign up"), message: Text("\(self.status?.localizedDescription ?? "Unknown error")"), dismissButton: .default(Text("OK")))
                })
                .alert(isPresented: self.$successfulSignUp, content: {
                    Alert(title: Text("Successfully signed up!"), message: Text("You can now go ahead and log in from the home page."), dismissButton: .default(Text("OK")))
                })
        }
    }
}
