//
//  TimerView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var currentCycle = 1
    @State var totalCyles: Int
    @State var session: Int
    @State var completedSessionTime: Int
    
    @AppStorage(UserdefaultKeys.focused) private var focusedTime = UserDefaults.standard.double(forKey: UserdefaultKeys.focused)
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("Session \(currentCycle) out of \(totalCyles)")
            
            
            Text("\(timeToString2(time: TimeInterval(session)))")
                .font(Font.monospacedDigit(.system(size: 50))())
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button(action: {
                self.session = 0
                self.mode.wrappedValue.dismiss()
                
            }) {
                ButtonTextStyle(title: "Stop")
            }
            .background(Color.blue)
            .cornerRadius(30)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Timer")
        .onAppear(){
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if self.session > 0 {
                    self.session -= 1
                    print(session)
                    print(completedSessionTime)
                    if self.session == 0 {
                        print("Timer reached 0")
                        self.focusedTime += Double(self.completedSessionTime)
                       self.mode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            
            let timestamp = NSDate().timeIntervalSince1970
            let myTimeInterval = TimeInterval(timestamp)
            let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
            
            switch phase {

            case .active:
                print("your code is here on scene become Active")
                
    

            case .inactive:
                print(">> your code is here on scene become inactive")
                print(timestamp)
                print(myTimeInterval)
                print(time)
                
                var timestamp1 = timestamp
                
            case .background:
                print(">> your code is here on scene go background")
                
            default:
                print(">> do something else in future")
            }
        }
        
    }
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
