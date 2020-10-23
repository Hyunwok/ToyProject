//
//  Extension.swift
//  MemoAlarm
//
//  Created by 이현욱 on 2020/10/23.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

extension UIViewController{
    func showToast(text: String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height - 500, width: 300,  height : 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        view.addSubview(toastLabel)
        toastLabel.text = text
        toastLabel.font = UIFont.boldSystemFont(ofSize: 18)
        toastLabel.alpha = 0.8
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        
        UIView.animate(withDuration: 1.0, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            (isBool) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
    }
}

extension UIViewController: UITextFieldDelegate {
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillDisa(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}


