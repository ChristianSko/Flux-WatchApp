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
            timerViewModel.start()
        })
        .onAppear(){
            NotificationManager.shared.NotifyWhenFinished(timeInterval: session)
            NotificationManager.shared.registerCategories()
            if self.session == 0 {
                print("Timer reached 0, Add time to ring")
                self.focusedTime += Double(self.completedSessionTime)
                self.mode.wrappedValue.dismiss()
            }
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
        timerViewModel.start()
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(totalCyles: 1, session: 20, completedSessionTime: 25)
    }
}
