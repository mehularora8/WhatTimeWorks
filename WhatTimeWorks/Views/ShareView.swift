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
        VStack {
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
            
            if self.successfullyCopied {
                Text("Copied!")
                    .foregroundColor(Colors.lightGray)
            }
        }
            .padding()
    }
}
