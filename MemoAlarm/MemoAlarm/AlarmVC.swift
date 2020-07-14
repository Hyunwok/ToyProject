import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import UserNotifications

//MARK: AlarmVC

class AlarmVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var showWhenTouchPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.appearance.titleWeekendColor = .red
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendarView.appearance.eventSelectionColor = .green
        self.setDelegate()
        reloadCalender()
        self.xibAndBtnIsHidden(value: true)
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                return
            } else {
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }
        })
    }
    
    @IBAction func piusAlarm(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
    }
    
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
        reloadCalender()
    }
}

//MARK: extension

extension AlarmVC: UITableViewDelegate, UITableViewDataSource {
    func a() {
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "알림"
        content.body = datePickerXib.alarmText
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: "LoveYou", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func xibAndBtnIsHidden(value: Bool) {
        showWhenTouchPlus.isHidden = value
        datePickerXib.isHidden = value
    }
    
    func reloadCalender() { // 이벤트 추가
        
    }
    
    
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let dateString = formatter.string(from: date)
//        for i in 0...AlarmVC.eventList.count {
//            if AlarmVC.eventList[i].contains(dateString) {
//                print(AlarmVC.eventList[i].contains(dateString))
//                return 1
//            }
//        }
//        return 0
//    }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 3 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(datePickerXib.list.count)
        return datePickerXib.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.identifier, for: indexPath) as! AlarmCell
        cell.textLabel?.text = datePickerXib!.alarmText
        print(datePickerXib!.alarmText)
        return cell
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
