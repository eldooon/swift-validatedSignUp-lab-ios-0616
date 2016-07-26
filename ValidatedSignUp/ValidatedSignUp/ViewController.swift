//
//  ViewController.swift
//  ValidatedSignUp
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.emailField.delegate = self
        self.userNameField.delegate = self
        self.passwordField.delegate = self

    }
    @IBAction func submitButtonTapped(sender: AnyObject) {
        print ("Submitted")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if validFields(textField) == false{
            let alert = UIAlertController(title: "Invalid", message: "Invalid Field!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Clear", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                print ("clear field")
                self.textFieldShouldClear(textField)
                }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        
        textField.text?.removeAll()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
       validFields(textField)
    }
    
    func validFields(textField : UITextField) -> Bool{
        let numberSet = NSCharacterSet(charactersInString: "1234567890")
        
        if textField == firstNameField {
            if textField.text?.characters.count > 0 && textField.text?.rangeOfCharacterFromSet(numberSet) == nil {
                print ("valid firstname")
                
                lastNameField.enabled = true
                
                return true
            }
        }
        
        if textField == lastNameField {
            if textField.text?.characters.count > 0 && textField.text?.rangeOfCharacterFromSet(numberSet) == nil {
                print ("valid lastname")
                
                emailField.enabled = true
                return true
            }
        }
        
        if textField == emailField {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            
            if textField.text?.characters.count > 0 && emailTest.evaluateWithObject(textField.text) {
                
                print ("valid email")
                
                userNameField.enabled = true
                return true
            }
        }
        
        if textField == userNameField {
            if textField.text?.characters.count > 0 && textField.text?.rangeOfCharacterFromSet(numberSet) == nil {
                print ("valid username")
                
                passwordField.enabled = true
                return true
            }
        }
        
        
        if textField == passwordField {
            if textField.text?.characters.count > 6 {
                print ("valid password")
                
                submitButton.enabled = true
                return true
            
            }
        }
        
        return false
    }
}

