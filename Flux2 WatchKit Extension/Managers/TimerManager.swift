//
//  File.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 16/5/21.
//

import SwiftUI
import UserNotifications

class TimerManager: ObservableObject {
    @Published var secondsElapsed: Int = 0
    var timer: Timer = Timer()
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.secondsElapsed > 0 {
                self.secondsElapsed -= 1
                if self.secondsElapsed == 0 {
                    print("Timer Reached 0")
                    self.timer.invalidate()
                }
            }
        }
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
    }
    
    func pause() {
            timer.invalidate()
        }
}




