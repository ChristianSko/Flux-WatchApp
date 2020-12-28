//
//  TimerView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @State var currentCycle = 1
    @State var totalCyles: Int
    @State var session: Int
    @State var completedSession: Int
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("\(currentCycle)/\(totalCyles)")
            
            Text("\(timeToString2(time: TimeInterval(session)))")
                .font(Font.monospacedDigit(.system(size: 50))())
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button(action: {
                //self.mode.wrappedValue.dismiss()
                print(session)
            }) {
                Text("Stop")
            }
            .background(Color.blue)
            .cornerRadius(30)
        }
        .onAppear(){
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if self.session > 0 {
                    self.session -= 1
                    print(session)
                    print(completedSession)
                    if self.session == 0 {
                        print("Timer reached 0")
                       // UserDefaults.standard.set(self.focusedTime, forKey: "Focused")
                       // self.mode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            
            case .active:
                print("Active")
                
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
        TimerView(totalCyles: 1, session: 20, completedSession: 25)
    }
}
