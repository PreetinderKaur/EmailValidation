//
//  EmailValidationUITests.swift
//  EmailValidationUITests
//
//  Created by Preet on 2019-04-07.
//  Copyright © 2019 Preetinder Marok. All rights reserved.
//

import XCTest

class EmailValidationUITests: XCTestCase {
     var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Take screenshot
    func testTakeScreenshot() {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "My Great Screenshot"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    // Test button and text field exists or not with accessibility idetentifier
    func testItemsExistsClick() {
        let validateButton = app.buttons["validate-button"]
        let textField = app.textFields["email-text-field"]
        
        XCTAssertTrue(validateButton.exists)
        XCTAssertTrue(textField.exists)


    }

}
