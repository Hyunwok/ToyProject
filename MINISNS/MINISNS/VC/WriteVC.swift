import UIKit
import Alamofire

// MARK: WriteVC

class WriteVC: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var imageData: Data!
    var image: UIImage!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageViewNilLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var goToMainBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingIndicator.isHidden = animated
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        tapImageView()
    }
    
    @IBAction func addRead(_ sender: Any) {
        
        if imageView.image == nil || ((titleTextField.text?.isEmpty)! == true) || titleTextField.text == "" {
            self.presentAlert(title: "실패", message: "사진과 글이 준비되지 않았습니다."); return
        }
        self.getLoadingIndicator(value: false)
        
        let header: HTTPHeaders = [
            "Content-Type":"multipart/form-data; boundary-\(UUID().uuidString)",
            /*"access_token":"\(UserDefaults.standard.string(forKey: "token")!)"*/
        ]
        
        AF.upload(multipartFormData: { (MultipartFormData) in
            guard let data = self.imageData else { return }
            MultipartFormData.append(data, withName: "file", fileName: UUID().uuidString + ".jpg", mimeType: "img/jpeg")
            MultipartFormData.append((self.titleTextField.text?.data(using: .utf8))!, withName: "content")
        }, to: "https://httpbin.org/post",usingThreshold: UInt64.init(), method: .post, headers: header).responseJSON { (result) in
            debugPrint(result)
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
    
    func getLoadingIndicator(value: Bool) {
        let indi = self.loadingIndicator
        switch value {
        case true:
            indi!.stopAnimating()
            indi!.isHidden = value
        case false:
            indi!.startAnimating()
            indi!.isHidden = value
        }
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
        imageView.image = pickedImage
        imageData = pickedImage.jpegData(compressionQuality: 0.025)
        imageViewNilLbl.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
