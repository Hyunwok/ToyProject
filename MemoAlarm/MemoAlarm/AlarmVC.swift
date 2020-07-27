import UIKit
import FSCalendar
import UserNotifications

//MARK: AlarmVC

class AlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    
    let userNoti = UNNotiManager()
    var listDate: String!
    var listText = [String]()
    var list = [String]()
    lazy var dateFormatter: DateFormatter = {
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
        self.aboutCalendar()
        self.reloadUserDefault()
        self.subjectXib.isHidden = true
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func changeXib(_ sender: UIButton) {
        if sender.isSelected {
            hideXib(value: true)
        } else {
            hideXib(value: false)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func presentXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
        calendarView.reloadData()
    }
    
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
        calendarView.reloadData()
        reloadUserDefault()
    }
    
    func reloadUserDefault() {
        let date = Date()
        var strings = UserDefaults.standard.object(forKey: "dayList") as? [Date]
        if strings == nil { return }
        for i in 0..<strings!.count {
            if strings?.count == 0 || strings?.count == nil || strings![i] == nil{
                return
            } else if date > strings![i] {
                strings!.remove(at: i)
            }
        }
        UserDefaults.standard.set(strings, forKey: "dayList")
    }
}


//MARK: extension

extension AlarmVC: DatePickerXibDelegate  {
    func listAppend(value: List, boolean: Bool) {
        listDate = value.dateList
        list.append(listDate!)
        self.listText.append("\(value.dateListText)")
        xibAndBtnIsHidden(value: boolean)
        tableView.reloadData()
        calendarView.reloadData()
        reloadUserDefault()
    }
    
    func hideXib(value: Bool) {
        calendarView.isHidden = !value
        subjectXib.isHidden = value
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
        cell.textLabel?.text = self.listText[indexPath.row]
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter.string(from: date)
        if self.list.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func aboutCalendar() {
        let ca = calendarView.appearance
        ca.headerMinimumDissolvedAlpha = 0.0;
        ca.eventOffset = CGPoint(x: 15, y: -35)
        ca.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
        ca.headerDateFormat = "yyyy년 M월"
        ca.headerTitleColor = .black
        ca.weekdayTextColor =  .black
    }
}

extension AlarmVC: UITextFieldDelegate {
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillDisa(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
// ud 저장, 텍스트 없는 것에 대한 처리, 
