# EmailValidation

* Users can type email address and validate it using 'Validate button' or 'Go' key from the keyboard. Texfield and button is fully accessibile with large fonts and voice-over. 
* Using kickbox.com to validate email with Email Verification API
* After tapping Validate button, alert will be displayed with validation result and reason
* If the reason is "invalid-domain" then alert has the ability to update the email text field with the suggested domain
* Text field has auto-correction enabled and using email-address keyboard type with 'Go' return key
* 'Go' return key will dismiss the keyboard if text-field is empty and call the validation api if its not
* TODO: Use Jazzy to make documention with all the comments

# Requirements
* Xcode 10
* Swift 4.2

# Implementation
* EmailResponse - Model using Codable to map the JSON response from kickbox.com ( Email Verification API)
* EmailValidationAPI -  Model to get validation result and parse decoded data to EmailResponse
* EmailValidatorViewController - Contains the code for email text field and validate button, actions for validate button to validate the email 
* DisplayAlert -  Helper class to create alert for result and reason type and show different message for each alert type and update the email text field for Invalid-domain reason

# UnitTests
* Testing the json response is mapped properly with EmailRespose using Mocked.json file
* Tests for all the result types: deliverable, undeliverable, risky, unknown
* TODO: More tests can be added to test alerts messages and other view controller functionality

# UITests
* Test to check email text field and validate button exists or not by checking with accessibility identifier
* Taking screenshots
* TODO: More detailed tests can be added using EarlGrey (iOS UI automation test framework )







