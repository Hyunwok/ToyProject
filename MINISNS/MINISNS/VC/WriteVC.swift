import UIKit
import Alamofire

// MARK: WriteVC

class WriteVC: UIViewController {
    
    let imagePicker = UIImagePickerController()

    var image: Data!
    var content: String!
    //var url: URL!
    var asd: String = ""
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageViewNilLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var goToMainBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadingIndicator.isHidden = true
        imagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        tapImageView()
    }
    
    @IBAction func addRead(_ sender: Any) {
        if imageView.image == nil || ((titleTextField.text?.isEmpty)! == true) || titleTextField.text == "" {
            self.presentAlert(title: "실패", message: "사진과 글이 준비되지 않았습니다."); return
        }

        self.getLoadingIndicator(value: false)
        let header: HTTPHeaders = ["Content-Type":"application/json",
                                   "access_token":"\(UserDefaults.standard.string(forKey: "token")!)"]
         AF.upload(multipartFormData: { (MultipartFormData) in
            MultipartFormData.append(self.image!, withName: "img", fileName: "img", mimeType: "img/jpeg")}, to: "http://10.156.145.141:3000/post", method: .post, headers: header).responseJSON { (result) in
                        debugPrint(result)
        }
//
//        AF.request("http://10.156.145.141:3000/post", method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { response in
//            debugPrint(response)
//            switch response.response?.statusCode {
//            case 200:
//                let alert = UIAlertController(title: "성공", message: "글이 올라갔습니다", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(_) in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        self.presentVC(identifier: "MainVC")}
//                    self.getLoadingIndicator(value: true)
//                    MainVC.data.append("")
//                }))
//                self.present(alert, animated: true, completion: nil)
//            case 403:
//                self.presentAlert(title: "실패", message: "로그인이 되어있지 않습니다.")
//                self.getLoadingIndicator(value: true)
//            case 500:
//                self.presentAlert(title: "에러", message: "작성 실패")
//                self.getLoadingIndicator(value: true)
//            default: self.getLoadingIndicator(value: true); return
//            }
//        }
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
    func getLoadingIndicator(value: Bool) {
        switch value {
        case true:
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = value
        case false:
            self.loadingIndicator.startAnimating()
            self.loadingIndicator.isHidden = value
        }
    }
    
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
        let actionSheet = UIAlertController(title: "선택", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "사진첩", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        image = pickedImage.jpegData(compressionQuality: 0.1)!
        imageView.image = pickedImage
        imageViewNilLbl.isHidden = true
        //url = info[.phAsset] as? URL
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
