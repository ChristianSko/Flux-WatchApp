//
//  MeasureUnit.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 26/5/21.
//

import Foundation


var cycles:  [String] {
    let hourInt = Array(0...12)
    let hourString = hourInt.map { String(format:"%02d", $0) }
    return hourString
}

var mins:  [String] {
    let minsecInt = Array(0...59)
    let minsecString = minsecInt.map { String(format:"%02d", $0) }
    return minsecString
}

enum MeasureUnitType: String {
    case cycle   = "CYCLES"
    case minutes = "MINUTES"
    
    var indices: Range<Int> {
        switch self {
        case .cycle:
            return cycles.indices
        case .minutes:
            return mins.indices
        }
    }
    
    var values: [String] {
        switch self {
        case .cycle:
            return cycles
        case .minutes:
            return mins
        }
    }
}
