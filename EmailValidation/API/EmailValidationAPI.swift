//
//  ValidateEmail.swift
//  ValidateEmail
//
//  Created by Preet on 2019-04-07.
//  Copyright © 2019 Preetinder Marok. All rights reserved.
//

import Foundation
import UIKit

/// Describes Email Validation API
///
/// Implementation of URLSession to get response
struct EmailValidationAPI {
    
    let emailAPI = "https://api.kickbox.com/v2/verify?"
    let apiKey = "live_07dbcd241412ac15bdc97bd01f58b9952dce900b82dcc49a2eb7114c739b0902"

    /// Validate the email
    ///
    /// - returns: validationCompletionHandler
    func validate(_ email: String, validationCompletionHandler: @escaping (EmailResponse?, Error?) -> Void) {
        // Url with email address and apikey
        guard let url = URL(string: emailAPI + "email=\(email)" + "&apikey=\(apiKey)") else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard let data = data else { return }
            
            // Parse JSON into EmailResponse struct using JSONDecoder
            guard let jsonResponse = try? JSONDecoder().decode(EmailResponse.self, from: data) else {
                return
            }
            // pass jsonResponse to validationCompletionHandler
            validationCompletionHandler(jsonResponse, nil)
        })
        
        task.resume()
        // function will end here and return
        // then after receiving HTTP response, the completionHandler will be called
    }
}
