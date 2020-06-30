import UIKit
import Alamofire

// MARK: WriteVC

class WriteVC: UIViewController {
    
    var imageData: URL!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageViewNilLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var goToMainBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        tapImageView()
    }
    
    @IBAction func addRead(_ sender: Any) {
        let param: [String:String] = ["file":"\(imageData!)","content":textView.text!]
        let header: HTTPHeaders = ["Content-Type":"multipart/form-data","access_token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        if imageView.image == nil || ((titleTextField.text?.isEmpty) == true) {
            let alert = UIAlertController(title: "실패", message: "사진과 글이 준비되지 않았습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
//
//        AF.upload(multipartFormData: { (MultipartFormData) in
//            MultipartFormData.append(self.imageData, withName: self.titleTextField.text!)
//            for (key, value) in param {
//                MultipartFormData.append((value.data(using: .utf8))!, withName: key)
//            }}, to: "http://10.156.145.141:3000/post", method: .post, headers: header).responseJSON { (result) in
//                switch result.response?.statusCode {
//                case 200: print(1)
//                case 403: print(2)
//                case 500: print(3)
//                default: print(4)
//                }
//                debugPrint(result)
//        }


        
        
        
        
        
        AF.request("http://10.156.145.141:3000/post", method: .post, parameters: param, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseJSON { response in
            debugPrint(response)
            switch response.response?.statusCode {
            case 200:
                let alert = UIAlertController(title: "성공", message: "글이 올라갔습니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(_) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.presentVC(identifier: "MainVC")}
                    MainVC.data.append("")
                }))
                self.present(alert, animated: true, completion: nil)
            case 403:
                self.presentAlert(title: "실패", message: "로그인이 되어있지 않습니다.")
            case 500:
                self.presentAlert(title: "에러", message: "작성 실패")
            default: return
            }
        }
    }
    
    @IBAction func goToMainBtn(_ sender: UIButton) {
        if imageView.image != nil || titleTextField.text?.isEmpty == false {
            let alert = UIAlertController(title: "알림", message: "사진과 글이 남아있습니다, 그래도 뒤로 가시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(_) in
                self.presentVC(identifier: "MainVC")
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            self.presentVC(identifier: "MainVC")
        }
    }
}

// MARK: Extension

extension WriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    func presentVC(identifier: String) {
        guard let vc = storyboard?.instantiateViewController(identifier: identifier) else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tapImageView() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "선택", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (_) in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "사진첩", style: .default, handler: { (_) in
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        imageView.image = pickedImage
        imageData = info[.imageURL] as? URL
        imageViewNilLbl.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
