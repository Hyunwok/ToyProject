import UIKit
import FSCalendar
import UserNotifications

//MARK: AlarmVC

class AlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    
    var listDate: String!
    var listText: String?
    var list = [String]()
    lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var subjectXib: SubjectXib!
    @IBOutlet weak var showWhenTouchPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
        self.xibAndBtnIsHidden(value: true)
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        let ca = calendarView.appearance
        ca.headerMinimumDissolvedAlpha = 0.0;
        ca.eventOffset = CGPoint(x: 15, y: -35)
        ca.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
        ca.headerDateFormat = "yyyy년 M월"
        ca.headerTitleColor = .black
        ca.weekdayTextColor =  .black
        subjectXib.isHidden = true
    }
    
    @IBAction func changeXib(_ sender: UIButton) {
        if sender.isSelected {
            hideXib(value: true)
        } else {
            hideXib(value: false)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func presentAlarm(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
        calendarView.reloadData()
    }
    
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
        calendarView.reloadData()
    }
}


//MARK: extension

extension AlarmVC: DatePickerXibDelegate  {
    func hideXib(value: Bool) {
        calendarView.isHidden = !value
        subjectXib.isHidden = value
    }
    
    func listAppend(value: List) {
        listDate = value.dateList
        list.append(listDate!)
        listText = value.dateListText
        tableView.reloadData()
    }
    
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.delegate = self
        datePickerXib.delegate = self
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
        cell.textLabel?.text = listText
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        if self.list.contains(dateString) {
            return 1
        }
        return 0
    }
}

