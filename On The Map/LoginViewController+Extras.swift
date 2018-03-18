//
//  LoginViewController+TextFieldDelegate.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 17/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController : UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: Keyboard Methods
    
    func subscribeToKeyboardNotifications() {
        // Use UIKeyboard WillChangeFrame instead of WillShow for supporting multiple keyboards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        // Removes all notification observers
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillChange(_ notification:Notification) {
        // Bottom Y point of the stack view
        let safeBottom = self.stackView.frame.maxY + 16
        
        // Top Y point of keyboard
        let keyboardTop = self.view.frame.height - getKeyboardHeight(notification)
        
        let offset = safeBottom - keyboardTop
        
        // If the stackview is completely visible, no need to shift view
        if (offset <= 0) {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= offset
        })
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        // Reset the view to it's original position
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.y = 0
        })
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
