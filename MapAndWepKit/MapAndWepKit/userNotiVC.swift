import UIKit
import UserNotifications

class userNotiVC: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (didAllow, error) in
                   
               })
               UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "히히"
        content.subtitle = "This is Subtitle : UserNotifications tutorial"
        content.body = "This is Body : 블로그 글 쓰기"
        content.summaryArgument = "Alan Walker"
        content.summaryArgumentCount = 40
    
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: "LoveYou", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}

extension userNotiVC {
    //To display notifications when app is running  inforeground
    
    //앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해줍니다.
    //viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해주는 것을 잊지마세요.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
        
    }
}
