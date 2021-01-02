//
//  TabItemView.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/31/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct TabItemView: View {
    
    var text: String
    var img: Image
    
    var body: some View {
        VStack {
            Text(self.text)
            
            self.img
        }
            .padding()
    }
}
