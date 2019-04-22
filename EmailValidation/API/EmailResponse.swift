//
//  ValidationResponse.swift
//  ValidateEmail
//
//  Created by Preet on 2019-04-07.
//  Copyright © 2019 Preetinder Marok. All rights reserved.
//

import Foundation

/// Describes a Email response
///
/// Implementation of Codable,
struct EmailResponse: Codable {
    /// The reason for the result
    let reason: Reason
    
    /// - role: true if the email address is a role address
    /// - free:  true if the email address uses a free email service like gmail.com or yahoo.com
    /// - disposable: true if the email address uses a disposable domain like trashmail.com or mailinator.com.
    /// - acceptAll: true if the email was accepted, but the domain appears to accept all emails addressed to that domain.
    /// - success:  true if the API request was successful
    let role, free, disposable, acceptAll, success: Bool
    
    /// - sendex: a quality score of the provided email address ranging between 0 (no quality) and 1
    let sendex: Float
    
    /// - email: Returns a normalized version of the provided email address
    /// - user: The user of the provided email address
    /// - domain: The domain of the provided email address
    /// - youMean: Returns a suggested email if a possible spelling error was detected
    let email, user, domain, message, youMean: String?

    
    /// - result: The verification result
    let result: Result
    
    enum CodingKeys: String, CodingKey {
        case result, reason, role, free, disposable, success
        case acceptAll = "accept_all"
        case youMean = "did_you_mean"
        case sendex
        case email, user, domain, message
    }
}

/// The reason for the result
enum Reason: String, Codable {
    case rejected = "rejected_email"
    case accepted = "accepted_email"
    case invalidDomain = "invalid_domain"
    case invalidEmail = "invalid_email"
    case lowQuality = "low_quality"
    case lowDeliverability = "low_deliverability"
    case invalidSMTP = "invalid_smtp"
    case unavailableSMTP = "unavailable_smtp"
    case timeout = "timeout"
    case unexpected = "unexpected_error"
    case noConnect = "no_connect"
}

/// The verification result
enum Result: String, Codable {
    case deliverable = "deliverable"
    case undeliverable = "undeliverable"
    case risky = "risky"
    case unknown = "unknown"
}
