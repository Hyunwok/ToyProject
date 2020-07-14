import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import UserNotifications

//MARK: AlarmVC

class AlarmVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UNUserNotificationCenterDelegate {

    static var list = [String]()
    static var eventList = [String]()
    var today: Int!
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var showWhenTouchPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.appearance.titleWeekendColor = .red
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
        self.setDelegate()
        reloadCalender()
        self.xibAndBtnIsHidden(value: true)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                return
            } else {
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }
        })
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        today = Int(formatter.string(from: Date()))
    }
    
    @IBAction func piusAlarm(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
    }
    
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
        reloadCalender()
    }
    
}

//let content = UNMutableNotificationContent()
//content.badge = 1
//content.title = "히히"
//content.subtitle = "This is Subtitle : UserNotifications tutorial"
//content.body = "This is Body : 블로그 글 쓰기"
//content.summaryArgument = "Alan Walker"
//content.summaryArgumentCount = 40
//
//let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
//let request = UNNotificationRequest(identifier: "LoveYou", content: content, trigger: trigger)
//
//UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)


//MARK: extension

extension AlarmVC: UITableViewDelegate, UITableViewDataSource {
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func xibAndBtnIsHidden(value: Bool) {
        showWhenTouchPlus.isHidden = value
        datePickerXib.isHidden = value
    }
    
    func reloadCalender() {
        var date = [String]()
        for i in AlarmVC.eventList { if today > Int(i)! { date.append(i) } }
        print(date)
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            
            return 0
        }
//        calendarView.appearance
//        datePickerXib.alarmDate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmVC.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
        cell.alarmLbl.text = datePickerXib.alarmText
        return cell
    }
}
