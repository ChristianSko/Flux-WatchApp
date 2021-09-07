//
//  TimerView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var currentCycle = 1
    @State var totalCyles: Int
    @State var session: Int
    @State var completedSessionTime: Int
    
    
    @StateObject var timerViewModel = TimerManager()
    @State private var notificationDate: Date = Date()
    
    @AppStorage(UserdefaultKeys.focused) private var focusedTime = UserDefaults.standard.double(forKey: UserdefaultKeys.focused)
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Session \(currentCycle) out of \(totalCyles)")
            
            
            Text("\(timeToString2(time: TimeInterval(timerViewModel.secondsElapsed)))")
                .font(Font.monospacedDigit(.system(size: 50))())
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button(action: {
                self.session = 0
                self.mode.wrappedValue.dismiss()
                timerViewModel.timer.invalidate()
                NotificationManager.shared.removeScheduledNotification()
                
            }) {
                ButtonTextStyle(title: "Stop")
            }
            .background(Color.brandPrimary)
            .cornerRadius(30)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Timer")
        .onAppear(perform: NotificationManager.shared.requestPermission)
        .onAppear(perform: {
            timerViewModel.secondsElapsed = session
            timerViewModel.sessionLength = session / 60
            timerViewModel.start()
            
            NotificationManager.shared.NotifyWhenFinished(timeInterval: session)
            NotificationManager.shared.registerCategories()
            
            if self.timerViewModel.secondsElapsed == 0 {
                self.mode.wrappedValue.dismiss()
            }})
        
        .onReceive(timerViewModel.$secondsElapsed) { _ in
            print(timerViewModel.secondsElapsed)
        }
        
        .onReceive(NotificationCenter.default.publisher(
            for: WKExtension.applicationWillResignActiveNotification
        )) { _ in
            movingToBackground()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: WKExtension.applicationDidBecomeActiveNotification
        )) { _ in
            movingToForeground()
        }
    }
    
    func movingToBackground() {
        print("Moving to the background")
        notificationDate = Date()
        timerViewModel.pause()
    }
    
    func movingToForeground() {
        print("Moving to the foreground")
        let deltaTime: Int = Int(Date().timeIntervalSince(notificationDate))
        timerViewModel.secondsElapsed -= deltaTime
        
        // I could add logic here? Once Open app is pressed, add time to timer and maybe animation? Also change stop timer to Next?
        
        if timerViewModel.secondsElapsed < 0 {
            timerViewModel.secondsElapsed = 0
            timerViewModel.stop()
        } else {
            timerViewModel.start()
        }
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(totalCyles: 1, session: 20, completedSessionTime: 25)
    }
}
