//
//  ColoredToggleStyle.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/31/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct NoLabelColoredToggleStyle: ToggleStyle {
    var offColor = Colors.brightYellow
    var onColor = Colors.midnightBlue
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
//            Text(label)
//            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Image(systemName: configuration.isOn ? "moon.fill" : "sun.max.fill")
                            .imageScale(.small)
//                        Circle()
//                            .fill(thumbColor)
                            .foregroundColor(Color.white)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(3)
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}
