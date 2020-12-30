//
//  Flux2App.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

@main
struct Flux: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView{
                    SessioView()
                    RingView(ringWidth: 15, percent: 100, backgroundColor: .blue, foregroundColors: [.white, .blue])
                }
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
