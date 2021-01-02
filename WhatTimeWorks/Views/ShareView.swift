//
//  ShareView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/30/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct ShareView: View{
    
    @State var successfullyCopied = false
    var id: String
    
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Colors.matteBlack)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Share your event")
                    .font(Font.system(size: 30, weight: .semibold, design: .rounded))
                    .padding(.vertical)
                
                Text("Share this event by copying the ID below and sending it to everyone you would like to attend the event.")
                
                HStack{
                    Spacer()
                    Text(id)
                    Image(systemName: "doc.on.doc.fill")
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.successfullyCopied = true
                            }
                            UIPasteboard.general.string = self.id
                        }
                    Spacer()
                }
                    .foregroundColor(.white)
                
                if self.successfullyCopied {
                    Text("Copied!")
                        .foregroundColor(Colors.lightGray)
                }
            }
                .padding()
        }
    }
}
