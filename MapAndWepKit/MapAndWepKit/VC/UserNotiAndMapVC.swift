import UIKit
import UserNotifications
import MapKit

//MARK: UserNotiVC

class UserNotiAndMapVC: UIViewController, UNUserNotificationCenterDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (didAllow, error) in
        })
        UNUserNotificationCenter.current().delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                return
            } else {
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }
        })
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
    
    func myLocation(latitude: CLLocationDegrees, longtitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        map.setRegion(locationRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        myLocation(latitude: (lastLocation?.coordinate.latitude)!, longtitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
    }
}

//MARK: extension

extension UserNotiAndMapVC {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
    }
}
