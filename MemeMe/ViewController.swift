//
//  ViewController.swift
//  MemeMe
//
//  Created by Rajanikant Deshmukh on 29/12/17.
//  Copyright © 2017 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let DEFAULT_TOP_TEXT = "TOP TEXT"
    let DEFAULT_BOTTOM_TEXT = "BOTTOM TEXT"
    
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0]
    
    @IBOutlet weak var navigatonBar: UINavigationBar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        topTextField.delegate = self
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        bottomTextField.delegate = self
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Set suitable View state
        setViewState(.BLANK)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Image picker methods

    @IBAction func pickImageFromGallery(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        launchImagePicker(imagePickerController)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        launchImagePicker(imagePickerController)
    }
    
    func launchImagePicker(_ imagePickerController: UIImagePickerController) {
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: NavigationBar Button Outlets
    @IBAction func onActionClicked(_ sender: Any) {
        // Create MemeObject
        let meme = generateMeme()
        let itemsToShare = [ meme.memedImage ]
        
        // Set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        // TODO Save item after sharing
        
        // Save Meme to AppDelegate Context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func onCancelClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Cancel Editing", message: "All the changes will be lost and Meme will reset. Are you sure?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "No, go back to editor."), style: .default,
                                                handler: {(action:UIAlertAction!) in
                                                    
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Reset", comment: "Reset editor."), style: .destructive,
                                                handler: {(action:UIAlertAction!) in
                                                    self.setViewState(.BLANK)
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageView.image = image
            picker.dismiss(animated: true, completion: nil)
            if (topTextField.text != DEFAULT_TOP_TEXT) && (bottomTextField.text != DEFAULT_BOTTOM_TEXT ) {
                setViewState(.MEME_COMPLETE)
            } else {
                setViewState(.MEME_EDITING)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        let alertController = UIAlertController(title: "No Image Selected", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Keyboard related methods
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (bottomTextField.isFirstResponder) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if (bottomTextField.isFirstResponder) {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: UITextField Delegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (topTextField.text != DEFAULT_TOP_TEXT) && (bottomTextField.text != DEFAULT_BOTTOM_TEXT ) {
            setViewState(.MEME_COMPLETE)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (topTextField == textField && topTextField.text == DEFAULT_TOP_TEXT) {
            topTextField.text = ""
        }
        if (bottomTextField == textField && bottomTextField.text == DEFAULT_BOTTOM_TEXT) {
            bottomTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // MARK: View State helper functions
    
    enum ViewState {
        case BLANK
        case MEME_EDITING
        case MEME_COMPLETE
    }
    
    func setViewState(_ state: ViewState) {
        switch state {
        case .MEME_EDITING:
            topTextField.isEnabled = true
            bottomTextField.isEnabled = true
            actionButton.isEnabled = false
            cancelButton.isEnabled = true
            break
        case .MEME_COMPLETE:
            topTextField.isEnabled = true
            bottomTextField.isEnabled = true
            actionButton.isEnabled = true
            cancelButton.isEnabled = true
            break
        default: // BLANK
            topTextField.isEnabled = false
            bottomTextField.isEnabled = false
            actionButton.isEnabled = false
            cancelButton.isEnabled = false
            // Set to Defaults
            imageView.image = nil
            topTextField.text = DEFAULT_TOP_TEXT
            bottomTextField.text = DEFAULT_BOTTOM_TEXT
            break
        }
    }
    
    // MARK: Meme sharing methods
    
    func generateMeme() -> MemeObject {
        let meme = MemeObject(
            topText: topTextField.text!,
            bottomText: bottomTextField.text!,
            originalImage: imageView.image!,
            memedImage: generateMemedImage()
        )
        return meme
    }
    
    func generateMemedImage() -> UIImage {
        // Hide NavigationBar and Toolbar
        navigatonBar.isHidden = true
        toolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.bounds.size)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show 'em again
        navigatonBar.isHidden = false
        toolbar.isHidden = false
        
        return memedImage
    }
}

