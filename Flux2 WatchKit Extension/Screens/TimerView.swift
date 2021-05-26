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
                
            }) {
                ButtonTextStyle(title: "Stop")
            }
            .background(Color.brandPrimary)
            .cornerRadius(30)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Timer")
        .onAppear(perform: requestPermission)
        .onAppear(perform: {
            timerViewModel.secondsElapsed = session
            timerViewModel.start()
        })
        .onAppear(){
            NotifyWhenFinished(timeInterval: session)
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
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
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


func NotifyWhenFinished(timeInterval: Int){
    
    let content = UNMutableNotificationContent()
    content.title = "Focus Session Completed"
    content.subtitle = "Break time!"
    content.sound = UNNotificationSound.default
    
    // show this notification one seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
    
    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    // add the notification request
    UNUserNotificationCenter.current().add(request)
}


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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(totalCyles: 1, session: 20, completedSessionTime: 25)
    }
}
