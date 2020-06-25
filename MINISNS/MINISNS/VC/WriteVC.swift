import UIKit

// MARK: WriteVC

class WriteVC: UIViewController {
    
    @IBOutlet weak var goToMainBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToMainBtn(_ sender: UIButton) {
        if imageView.image != nil {
            let alert = UIAlertController(title: "경고", message: "사진이 선택되었습니다 그래도 뒤로 가시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(_) in
                self.presentVC()
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            self.presentVC()
        }
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        tapImageView()
    }
    
    @IBAction func addRead(_ sender: Any) {
        if imageView.image == nil {
            let alert = UIAlertController(title: "실패", message: "사진이 선택되지 않았습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        let alert = UIAlertController(title: "성공", message: "글이 올라갔습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: {() in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presentVC()
            }
        })
    }
}

// MARK: Extension

extension WriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "MainVC") else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

