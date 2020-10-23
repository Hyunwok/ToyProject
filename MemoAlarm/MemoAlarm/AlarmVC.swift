import UIKit
import FSCalendar
import UserNotifications
import RxCocoa
import RxSwift

//MARK: AlarmVC

class AlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    
    let obs: Observable<[Date]>?
    
    var calendarDataSource: [String:String] = ["2020-08-07":"잉기모띠"]
    let commentString: BehaviorRelay<[String]> = .init(value: [""])
    let userNoti = UNNotiManager()
    var listDate: String!
    var listText = [String]()
    var list = [String]()
    
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
//    @IBOutlet weak var showWhenTouchPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
        self.xibAndBtnIsHidden(value: true)
        self.calendarSetting()
        self.reloadUserDefault()
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func presentXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: sender.isSelected)
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
        
        tableView.reloadData()
        calendarView.reloadData()
        reloadUserDefault()
        if boolean {
            xibAndBtnIsHidden(value: boolean)
            return
        } else {
            showToast(text: "텍스트가 비었습니다")
        }
    }
    
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
//        tableView.delegate = self
//        tableView.dataSource = self
        calendarView.delegate = self
        datePickerXib.delegate = self
        calendarView.dataSource = self
    }
    
    func xibAndBtnIsHidden(value: Bool) {
//        showWhenTouchPlus.isHidden = value
        datePickerXib.isHidden = value
    }
    
    
}

extension AlarmVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = dateFormatter.string(from: date)
        if self.list.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func calendarSetting() {
        let ca = calendarView.appearance
        ca.headerMinimumDissolvedAlpha = 0.0;
        ca.eventOffset = CGPoint(x: 15, y: -35)
        ca.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
        ca.headerDateFormat = "yyyy년 M월"
        ca.headerTitleColor = .black
        ca.weekdayTextColor =  .black
    }
    
    func calendar(_ calendar: FSCalendar, didselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let date = dateFormatter.string(from: date)
        if let comment = calendarDataSource[date] {
//            commentString.accept(comment)
        }
    }
}



let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()
