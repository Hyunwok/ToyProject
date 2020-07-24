import UIKit
import UserNotifications

class UNNotiManager: NSObject, UNUserNotificationCenterDelegate {
    
    let center = UNUserNotificationCenter.current()
    
    func register() {
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound], completionHandler: { (authorized, error) in
            if !authorized {print("App is useless becase you did not allow notification")
            } else if error != nil {
                print(error!.localizedDescription)
            }
        })
    }
    
    func showEduNotification(date: Date){
        let content = UNMutableNotificationContent()
        content.title = "알림"
        content.body = "챙겨야할 것이 있습니다!"
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let err = error {
                print("Error:\(err.localizedDescription)")
            }
        }
    }
}
