//
//  DisplayError.swift
//  ValidateEmail
//
//  Created by Preet on 2019-04-07.
//  Copyright © 2019 Preetinder Marok. All rights reserved.
//

import Foundation
import UIKit

/// Describes Display alert
///
/// Implementation of alert for validation result
class DisplayAlert {
    var isInvalidDomail: Bool = false
    
    ///displays alert message with respective response result: deliverable, risky, unknown, undeliverable
    static func showAlert(for response: EmailResponse, inViewController viewController: EmailValidatorViewController, handler: ((UIAlertAction) -> ())? = nil, completion: (() -> ())? = nil) {
        
        var title, message: String
        let reason = response.reason
        var alert = UIAlertController()
        
        switch response.result {
        case .deliverable:
            title = "Deliverable"
        case .risky:
            title = "Email may bounce"
        case .unknown:
            title = "Please try again"
        case .undeliverable:
            title = "Undeliverable"
        }
        
        message = AlertMessage.alertMessage(reason: response.reason)
        
        /// Check if the validation reason is Invalid-domain then pass a message with suggested email address and by tapping YES it will update the textField
        if reason == .invalidDomain {
            if let value = response.youMean {
                alert = UIAlertController(title: "Invalid Domain", message: "Do you mean \(value)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    viewController.emailTextField.text = response.youMean
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: handler))
            }
        } else {
            alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        }
        
        // present the alert controller
        viewController.present(alert, animated: false, completion: completion)
    }
}

/// AlertMessage return message for result reason
struct AlertMessage {
    
    static func alertMessage(reason: Reason) -> String {
        var message: String
        switch reason {
        case .rejected:
            message = "Email address does not exist"
        case .invalidDomain:
            message = "Invalid Domain"
        case .accepted:
            message = "Email address is deliverable"
        case .invalidEmail:
            message = "Invalid Email Address"
        case .lowQuality, .lowDeliverability:
            message = "Email address has quality issues"
        case .timeout:
            message = "TimeOut"
        default:
            message = "Invalid Email Address"
        }
        return message
    }
}
