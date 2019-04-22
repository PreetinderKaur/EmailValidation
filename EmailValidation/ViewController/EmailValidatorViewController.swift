//
//  EmailValidatorViewController.swift
//  ValidateEmail
//
//  Created by Preet on 2019-04-07.
//  Copyright © 2019 Preetinder Marok. All rights reserved.
//

import UIKit

class EmailValidatorViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var validateButton: UIButton!
    
    let emailValidation = EmailValidationAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateButton.isEnabled = false
        updateValidateButton()
    }
    
    /// TextField value is changed
    @IBAction func textFieldChanged(_ sender: Any) {
        updateValidateButton()
    }
    
    /// Update validate button color for its state
    func updateValidateButton()  {
        validateButton.isEnabled  = emailTextField.hasText ? true : false
        validateButton.backgroundColor = validateButton.isEnabled ? UIColor(red: 0, green: 100/255, blue: 0, alpha: 1) : UIColor.lightGray
    }
    
    /// Validate the email using Kickbox.com API
    @IBAction func validateEmail(_ sender: Any) {
        if let email = emailTextField.text {
            emailValidation.validate(email) { (response, error) in
                if let emailResponse = response {
                    // show alert for respective result
                    DispatchQueue.main.async {
                        DisplayAlert.showAlert(for: emailResponse, inViewController: self)
                    }
                }
            }
        }
    }
}

// MARK: UITextFieldDelegate
extension EmailValidatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Check if the textfield is not empty the update the validate button and call the validate api for email validation
        if textField.hasText {
            updateValidateButton()
            validateEmail(self)
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

