//
//  NotificationView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/07/21.
//

import Foundation
import UserNotifications
import CoreLocation


class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var settings: UNNotificationSettings?
    
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func NotifyWhenFinished(timeInterval: Int){
        
        let content = UNMutableNotificationContent()
        content.title = "Session Completed"
        content.body = "Good job!"
        content.subtitle = "Break time!"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        // show this notification one seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add the notification request
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()

        let show = UNNotificationAction(identifier: "show", title: "Go to app…", options: .foreground)
        let startBreak = UNNotificationAction(identifier: "break", title: "Start break Timer", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, startBreak], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")

            case "show":
                // the user tapped our "show more info…" button
                print("Show more information…")
                break
                
            case "break":
                // the user tapped our "show more info…" button
                print("Show more information…")
                break

            default:
                break
            }
        }

        // you must call the completion handler when you're done
        completionHandler()
    }

    
    func removeScheduledNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    
//    func movingToBackground(timer: Int) {
//        print("Moving to the background")
//        notificationDate = Date()
//        timerViewModel.pause()
//    }
//
//    func movingToForeground() {
//        print("Moving to the foreground")
//        let deltaTime: Int = Int(Date().timeIntervalSince(notificationDate))
//        timerViewModel.secondsElapsed -= deltaTime
//        timerViewModel.start()
//    }
//
    
    
}





































//class NotificationManager: ObservableObject {
//  static let shared = NotificationManager()
//  @Published var settings: UNNotificationSettings?
//
//
//  func scheduleNotification(task: Task) {
//
//    let content = UNMutableNotificationContent()
//    content.title = task.name
//    content.body = "Gentle reminder for your task!"
//
//
//    var trigger: UNNotificationTrigger?
//    switch task.reminder.reminderType {
//    case .time:
//      if let timeInterval = task.reminder.timeInterval {
//        trigger = UNTimeIntervalNotificationTrigger(
//          timeInterval: timeInterval,
//          repeats: task.reminder.repeats)
//      }
//
//    case .calendar:
//      if let date = task.reminder.date {
//        trigger = UNCalendarNotificationTrigger(
//          dateMatching: Calendar.current.dateComponents(
//            [.day, .month, .year, .hour, .minute],
//            from: date),
//          repeats: task.reminder.repeats)
//      }
//
//
//    default:
//      return
//    }
//
//    // 4
//    if let trigger = trigger {
//      let request = UNNotificationRequest(
//        identifier: task.id,
//        content: content,
//        trigger: trigger)
//      // 5
//      UNUserNotificationCenter.current().add(request) { error in
//        if let error = error {
//          print(error)
//        }
//      }
//    }
//  }
//
//
//  func requestAuthorization(completion: @escaping  (Bool) -> Void) {
//    UNUserNotificationCenter.current()
//      .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
//        self.fetchNotificationSettings()
//        completion(granted)
//      }
//  }
//
//  func fetchNotificationSettings() {
//    UNUserNotificationCenter.current().getNotificationSettings { settings in
//
//      DispatchQueue.main.async {
//        self.settings = settings
//      }
//    }
//  }
//
//  func removeScheduledNotification(task: Task) {
//    UNUserNotificationCenter.current()
//      .removePendingNotificationRequests(withIdentifiers: [task.id])
//  }
//
//}
