import UIKit

// MARK: MainVC

class MainVC: UIViewController {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertSheetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "token") == nil {
            self.presentVC()
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBAction func setAlertSheet(_ sender: UIButton) {
        
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "선택하세요", message: "무엇을 선택하시겠나요?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "로그아웃", style: .default, handler: { (_) in
            UserDefaults.standard.removeObject(forKey: "token")
            self.presentVC()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "사진첩", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .default, handler: nil ))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        return cell
    }
    
    
    private func presentVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginVC") else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
}



