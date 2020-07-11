import UIKit

class DatePickerXib: UIView {
    
    private let xibName = "DatePickerView"
    var alarmText: String!

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var okBtn: UIButton!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        datePicker.addTarget(self, action: #selector(abc), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else { return }
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func getOk(_ sender: UIButton) {
        
    }
    
    @objc func abc() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let date = formatter.string(from: datePicker.date)
        alarmText = date
    }
}
