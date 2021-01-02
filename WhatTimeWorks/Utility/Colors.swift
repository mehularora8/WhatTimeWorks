//
//  Colors.swift
//  WhatTimeWorks
//
//  Created by Mehul Arora on 12/14/20.
//  Copyright © 2020 Mehul Arora. All rights reserved.
//

import SwiftUI

struct Colors {
    static var darkGray  = Color(red: 66 / 255, green: 66 / 255, blue: 66 / 255)
    
    static var lightGray = Color(red: 219 / 255, green: 219 / 255, blue: 219 / 255)
    
    static var royalBlue = Color(red: 0 / 255, green: 33 / 255, blue: 81 / 255)
    
    static var sunset    = LinearGradient(gradient: Gradient(colors:[Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static var midnightBlue = Color(red: 0, green: 51 / 255, blue: 102 / 255)
    
    static var brightYellow = Color(red: 245 / 255, green: 170 / 255, blue: 14 / 255)
    
    static var matteBlack = Color(red: 23 / 255, green: 23 / 255, blue: 23 / 255)
    
    static var UIMatteBlack = UIColor(red: 23 / 255, green: 23 / 255, blue: 23 / 255, alpha: 1.0)
    
    static var funkyBlue: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 29/255, green: 199/255, blue: 253/255), Color(red: 69/255, green: 122/255, blue: 252/255)]), startPoint: .bottomTrailing, endPoint: .topLeading)
    
    static var smoothGray = LinearGradient(gradient: Gradient(colors: [Color(red: 219 / 255, green: 219 / 255, blue: 219 / 255), Color(red: 177/255, green: 191/255, blue: 216/255)]), startPoint: .bottomTrailing, endPoint: .topLeading)
}
