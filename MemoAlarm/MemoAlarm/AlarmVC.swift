import UIKit

import FSCalendar
import UserNotifications
import RxCocoa
import RxSwift

//MARK: AlarmVC

class AlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    let userNoti = UNNotiManager()
    private var bool = false
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        self.calendarSetting()
        bindAction()
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


//MARK: extension

extension AlarmVC {
    func bindAction() {
        alarmPlusBtn.rx.tap
            .subscribe({_ in
                self.datePickerXib.isHidden = false
            })
            .disposed(by: disposeBag)
        
        datePickerXib.okBtn.rx.tap
            .map { self.tableView.reloadData() }
            .map { self.datePickerXib.alarmTextField.text?.isEmpty ?? false }
            .subscribe(onNext: { b in
                if !b {
                    self.datePickerXib.isHidden = true
                }
            }).disposed(by: disposeBag)
    }
    
    func bindUI() {
        datePickerXib.alarmList?
            .asObservable()
            .map { [$0] }
            .bind(to: tableView.rx.items(cellIdentifier: AlarmCell.identifier, cellType: AlarmCell.self)) { _, list, cell in
                cell.alarmText.text = list.dateListText
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
        }
    
    func calendarSetting() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.reloadData()
        let ca = calendarView.appearance
        ca.headerMinimumDissolvedAlpha = 0.0;
        ca.eventOffset = CGPoint(x: 15, y: -35)
        ca.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
        ca.headerDateFormat = "yyyy년 M월"
        ca.headerTitleColor = .black
        ca.weekdayTextColor =  .black
    }
}

extension AlarmVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        self.datePickerXib.alarmList?.subscribe(onNext: { lists in
//            for i in 0...lists.count {
//                if lists[i].date == date {
//                }
//            }
//        }).disposed(by: disposeBag)
//        return 0
//    }
    
    /// 선택한 날짜의 이벤트 보여주기
    //    func calendar(_ calendar: FSCalendar, didselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        let dateString = dateFormatter.string(from: date)
    //        list.append(dateFormatter.string(from: DatePickerXib.alarmList![0].date))
    //        if list.contains(dateString) {
    ////            테이블뷰와 합체해야댐
    //        }
    //    }
}



let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()


