//
//  TimerView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) { phase in
                switch phase {
                    case .active:
                        print(">> your code is here on scene become active")
                    case .inactive:
                        print(">> your code is here on scene become inactive")
                    case .background:
                        print(">> your code is here on scene go background")
                    default:
                        print(">> do something else in future")
                }
            }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
