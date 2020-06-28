import UIKit

// MARK: MainVC

class MainVC: UIViewController {
    
    public var data = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertSheetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: "CollectionViewCell")
    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.string(forKey: "token") == nil {
//            self.presentVC(identifier: "LoginVC")
//        }
//    }
    
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


// MARK: extension

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        //cell?.configure(with: )
        return cell
    }
    
    private func presentVC(identifier: String) {
        guard let vc = storyboard?.instantiateViewController(identifier: identifier) else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}



