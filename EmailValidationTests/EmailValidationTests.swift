//
//  EmailValidationTests.swift
//  EmailValidationTests
//
//  Created by Preet on 2019-04-07.
//  Copyright © 2019 Preetinder Marok. All rights reserved.
//

import XCTest
@testable import EmailValidation

class EmailValidationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///Use Mocked response to test Json Mapping with codable
    func testJSONMapping() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Mocked", withExtension: "json") else { return }
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonResponse = try! decoder.decode(EmailResponse.self, from: data)
        
        XCTAssertEqual(jsonResponse.email, "bill.test@gamil.com")
        XCTAssertEqual(jsonResponse.domain, "gamil.com")
        XCTAssertEqual(jsonResponse.youMean, "bill.test@gmail.com")
        XCTAssertEqual(jsonResponse.result.rawValue, "undeliverable")
        XCTAssertEqual(jsonResponse.reason.rawValue, "rejected_email")
        XCTAssertEqual(jsonResponse.user, "bill.test")
        XCTAssertTrue(jsonResponse.success, "success")
        XCTAssertFalse(jsonResponse.acceptAll, "accept_all")
    }
    
    ///Test Email Validation for deliverable email
    func testEmailValidationDeliverable() {
        let expectation = self.expectation(description: "Email Validation")
        
        var resultResponse: Result?
        EmailValidationAPI().validate("preetinder@gmail.com") { (response, error) in
            resultResponse = response?.result
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssertEqual(resultResponse, Result.deliverable)
    }
    
    ///Test Email Validation for undeliverable email
    func testEmailValidationUndeliverable() {
        let expectation = self.expectation(description: "Email Validation")
        
        var resultResponse: Result?
        EmailValidationAPI().validate("test@abc") { (response, error) in
            resultResponse = response?.result
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssertEqual(resultResponse, Result.undeliverable)
        
    }
    
    ///Test Email Validation for risky email
    func testEmailValidationRisky() {
        let expectation = self.expectation(description: "Email Validation")
        
        var resultResponse: Result?
        EmailValidationAPI().validate("test@abc.com") { (response, error) in
            resultResponse = response?.result
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssertEqual(resultResponse, Result.risky)
    }

}
