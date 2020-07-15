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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "addHellow" {
            print("Say Hellow!")
        }else{
            print("Say Bye~")
        }
    }
    
    func showEduNotification(date: Date){
        let content = UNMutableNotificationContent()
        content.title = "알림"
        content.body = "챙겨야할 것이 있습니다!"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        let request = UNNotificationRequest(identifier: "eduNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { error in
            if let err = error {
                print("Error:\(err.localizedDescription)")
            }
        }
    }
}
