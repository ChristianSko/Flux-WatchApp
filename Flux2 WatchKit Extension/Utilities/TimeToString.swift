//
//  TimeToString.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 31/8/21.
//

import Foundation


// - TO DO:
//TONeed to figure out what they do and rename for clarity

func timeToString(from timeInterval: TimeInterval) -> String {
    
    let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
    let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
    
    return String(format: "%.2d:%.2d", minutes, seconds)
    
}

func timeToString2(time: TimeInterval) -> String {
    
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i",minutes, seconds)
    
}
