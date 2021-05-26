//
//  MeasureUnit.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 26/5/21.
//

import Foundation


var hour:  [String] {
    let hourInt = Array(0...23)
    let hourString = hourInt.map { String(format:"%02d", $0) }
    return hourString
}

var minsec:  [String] {
    let minsecInt = Array(0...59)
    let minsecString = minsecInt.map { String(format:"%02d", $0) }
    return minsecString
}

enum MeasureUnitType: String {
    case hours   = "MINUTES"
    case minutes = "SECONDS"
    case seconds = "CYCLES"
    
    var indices: Range<Int> {
        switch self {
        case .hours:
            return hour.indices
        case .minutes:
            return minsec.indices
        case .seconds:
            return minsec.indices
        }
    }
    
    var values: [String] {
        switch self {
        case .hours:
            return hour
        case .minutes:
            return minsec
        case .seconds:
            return minsec
        }
    }
}
