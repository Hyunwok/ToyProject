import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import UserNotifications

//MARK: AlarmVC

class AlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    
    var listText: String?
    var list = [String]()
    var eventList = [String]()
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var showWhenTouchPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
        self.xibAndBtnIsHidden(value: true)
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
    }
    
    @IBAction func piusAlarm(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
    }
    
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
        let manager = UNNotiManager()
    }
}

//MARK: extension

extension AlarmVC: DatePickerXibDelegate  {
    func listAppend(value: String) {
        listText = value
        list.append(listText!)
    }
    
    func eventListAppend(value: String) {
        eventList.append(value)
    }
    
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    func xibAndBtnIsHidden(value: Bool) {
        showWhenTouchPlus.isHidden = value
        datePickerXib.isHidden = value
    }
}

extension AlarmVC: UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.identifier, for: indexPath) as! AlarmCell
        cell.textLabel?.text = listText!
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        if eventList.contains(dateString) {
            return 1
        }
        return 0
    }
}

