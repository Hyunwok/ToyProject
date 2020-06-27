import UIKit
import Alamofire

// MARK: WriteVC

class WriteVC: UIViewController {
    
    var imageData: Data!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageViewNilLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var goToMainBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  textView.isSelectable = false
        imageViewNilLbl.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        tapImageView()
    }
    
    @IBAction func addRead(_ sender: Any) {
        if imageView.image == nil || ((titleTextField.text?.isEmpty) != nil) {
            let alert = UIAlertController(title: "실패", message: "사진과 글이 준비되지 않았습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(self.imageData, withName: "\(self.titleTextField.text!)")}, to: "", method: .post, headers: ["Content-Type":"multipart/form-data"]).responseJSON { (response) in
                let status = response.response?.statusCode
                switch status {
                case 200: print(1)
                case 400: print(2)
                default: print(3)
                }
        }
        
        let alert = UIAlertController(title: "성공", message: "글이 올라갔습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.presentVC()}
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func goToMainBtn(_ sender: UIButton) {
        if imageView.image != nil || textView.text != nil {
            let alert = UIAlertController(title: "알림", message: "사진과 글이 남아있습니다, 그래도 뒤로 가시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(_) in
                self.presentVC()
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            self.presentVC()
        }
    }
}

// MARK: Extension

extension WriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    func presentVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "MainVC") else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageData = image.jpegData(compressionQuality: 1)
        imageView.image = image
        imageViewNilLbl.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

