//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Rajanikant Deshmukh on 26/01/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelagate : NSObject, UITextFieldDelegate {
    
    override init() {
        super.init()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text == "TOP TEXT") || (textField.text == "BOTTOM TEXT" ) {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
