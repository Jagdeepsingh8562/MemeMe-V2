//
//  textfiedDelegate.swift
//  ImagePicker
//
//  Created by Jagdeep Singh on 06/01/21.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    var activeTF = UITextField()
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
