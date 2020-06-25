import UIKit

// MARK: MainVC

class MainVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertSheetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "token") == nil {
            self.presentVC(identifier: "LoginVC")
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: "MyCell")
    }
    
    @IBAction func setAlertSheet(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "선택하세요", message: "무엇을 선택하시겠나요?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "로그아웃", style: .default, handler: { (_) in
            UserDefaults.standard.removeObject(forKey: "token")
            self.presentVC(identifier: "LoginVC")
        }))
        actionSheet.addAction(UIAlertAction(title: "사진 올리기", style: .default, handler: { (_) in
            self.presentVC(identifier: "WriteVC")
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil ))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CollectionViewCell
        //cell?.configure(with: imagePicker)
        return cell
    }
    
    private func presentVC(identifier: String) {
        guard let vc = storyboard?.instantiateViewController(identifier: identifier) else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}



