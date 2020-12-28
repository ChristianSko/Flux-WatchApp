//
//  Flux2App.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

@main
struct Flux2App: App {
    
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                SessioView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
