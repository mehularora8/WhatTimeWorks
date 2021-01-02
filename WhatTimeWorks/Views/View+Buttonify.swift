//
//  View+Buttonify.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/31/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct Buttonify: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Colors.funkyBlue)
            
            content
                .foregroundColor(.white)
        }
            .frame(height: 40)
            .padding()
    }
}

extension View {
    func buttonify() -> some View {
        self.modifier(Buttonify())
    }
}
