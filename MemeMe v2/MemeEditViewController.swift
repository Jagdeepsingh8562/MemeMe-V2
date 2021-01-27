//
//  MemeEditViewController.swift
//  MemeMe v2
//
//  Created by Jagdeep Singh on 04/01/21.
//

import UIKit

class MemeEditViewController: UIViewController , UITextFieldDelegate {
    
    
    var memedImage: UIImage!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navbar: UINavigationBar!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth:  -3.0
    ]
    let textfieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        subscribeToKeyBoardNotifications()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(true)
          unsubscribeToKeyboardNotifications()
        
      }
    
    func setupTextField(_ textField: UITextField, text: String) {
        textField.delegate = textfieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = text
    }
    
    //Pick an Image and Capture on UIViewController
    
    func presentPickerViewController(source: UIImagePickerController.SourceType) {
    //TODO: - Create a `UIImagePickerController`, set its source, and present it here.
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        presentPickerViewController(source: .photoLibrary)
    }
    
    @IBAction func captureAnImage(_ sender: Any) {
        presentPickerViewController(source: .camera)
    }
    
    
    //adjust view according to keyboard
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if textfieldDelegate.activeTF == bottomTextField {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func subscribeToKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self , name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //meme Image
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar
        toolbar.isHidden = true
        navbar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        toolbar.isHidden = false
        navbar.isHidden = false
        
        return memedImage
    }
    //save meme
    
    func save() {
        memedImage = generateMemedImage()
            // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    //share meme
    
    @IBAction func shareButton(_ sender: Any) {
        memedImage = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [memedImage as UIImage], applicationActivities: [])
        vc.completionWithItemsHandler = {(
            activityType: UIActivity.ActivityType?,
            completed: Bool,
            arrayReturnedItems: [Any]?,
            error: Error?) in
            if completed {
                self.save()
                self.dismiss(animated: true)
            }
            
            self.dismiss(animated: true)
        }
        present(vc, animated: true)
    }
    //cancel button
    
    
    @IBAction func cancelButton(_ sender: Any) {
        shareButton.isEnabled = false
        imageView.image = nil
        topTextField.text = ""
        bottomTextField.text = ""
        
    }
    
}

//MARK: - Extensions
extension MemeEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //display selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.imageView.image = image
            setupTextField(topTextField, text: "TOP")
            setupTextField(bottomTextField, text: "BOTTOM")
            shareButton.isEnabled = true
        }
        
        
        dismiss(animated: true, completion: nil)
    }
}

