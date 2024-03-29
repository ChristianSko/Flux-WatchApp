//
//  Flux2App.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI


@main
struct Flux: App {

    // Test
    @Environment(\.scenePhase) private var GeneralscenePhase
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView{
                    SessionView()
                    RingView(ringWidth: 15, percent: 15, backgroundColor: Color.brandPrimary, foregroundColors: [.white, Color.brandPrimary])
                }
            }
        }
        .onChange(of: GeneralscenePhase) { phase in
            
            let timestamp = NSDate().timeIntervalSince1970
            let myTimeInterval = TimeInterval(timestamp)
            let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
            
            switch phase {

            case .active:
                print("your code is here on scene become Active")

            case .inactive:
                print(">> Generalscene Phase your code is here on scene become inactive")
            
                print(time)
                
            case .background:
                print(">> GeneralscenePhaseyour code is here on scene go background")
                
            default:
                print(">> do something else in future")
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
