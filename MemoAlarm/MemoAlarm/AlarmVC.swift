import UIKit

import FSCalendar
import UserNotifications
import RxCocoa
import RxSwift

//MARK: AlarmVC

class AlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    let userNoti = UNNotiManager()
    var list = [String]()
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var hiddenBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
        self.calendarSetting()
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func presentXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: sender.isSelected)
        calendarView.reloadData()
    }
    
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: sender.isSelected)
        calendarView.reloadData()
//        reloadUserDefault()
    }
}


//MARK: extension

extension AlarmVC {
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    func xibAndBtnIsHidden(value: Bool) {
        hiddenBtn.isHidden = value
        datePickerXib.isHidden = value
    }
}

extension AlarmVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension AlarmVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 캘린더 세팅
    func calendarSetting() {
        calendarView.reloadData()
        let ca = calendarView.appearance
        ca.headerMinimumDissolvedAlpha = 0.0;
        ca.eventOffset = CGPoint(x: 15, y: -35)
        ca.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
        ca.headerDateFormat = "yyyy년 M월"
        ca.headerTitleColor = .black
        ca.weekdayTextColor =  .black
    }
    
    // 이벤트 갯수 반환 함수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        let dateString = dateFormatter.string(from: date)
//        list.append(dateFormatter.string(from: DatePickerXib.alarmList![0].date))
//        if list.contains(dateString) {
//            return 1
//        }
        return 0
    }

    /// 선택한 날짜의 이벤트 보여주기
    func calendar(_ calendar: FSCalendar, didselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateString = dateFormatter.string(from: date)
        list.append(dateFormatter.string(from: DatePickerXib.alarmList![0].date))
        if list.contains(dateString) {
//            테이블뷰와 합체해야댐
        }
    }
}



let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()
