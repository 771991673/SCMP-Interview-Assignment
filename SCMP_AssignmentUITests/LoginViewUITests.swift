//
//  LoginViewUITests.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import XCTest

class LoginViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    

    func testLoginViewElementsExist() throws {
        
        XCTAssertTrue(app.staticTexts["loginTitle"].exists, "Login title should be visible")
        XCTAssertTrue(app.textFields["emailTextField"].exists, "Email text field should be visible")
        XCTAssertTrue(app.secureTextFields["passwordTextField"].exists, "Password text field should be visible")
        XCTAssertTrue(app.buttons["loginButton"].exists, "Login button should be visible")
    }
    

    
    func testEmptyFieldLogin() throws {
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let alertText = app.staticTexts["toastText"]
        XCTAssertEqual(alertText.label, "Please fill in all fields", "The text view does not contain the expected text")
    }
    
    func testInvalidPassword() throws {
        
        let emailTextField = app.textFields["emailTextField"]
        emailTextField.tap()
        emailTextField.typeText("test@example.com")
        
        let passwordTextField = app.secureTextFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("password123")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let alertText = app.staticTexts["toastText"]
        XCTAssertEqual(alertText.label, "Password must be 6–10 alphanumeric characters", "The text view does not contain the expected text")
    }
    
    
    func successfulLogin() throws {
        
        let emailTextField = app.textFields["emailTextField"]
        emailTextField.tap()
        emailTextField.typeText("eve.holt@reqres.in")
        
        let passwordTextField = app.secureTextFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("cityslicka")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
    }
    
    func testAutoLogin() throws {
        
        try successfulLogin()
        
        let staffViewTitle = app.staticTexts["staffViewTitle"]
        XCTAssertTrue(staffViewTitle.waitForExistence(timeout: 10), "Staff view did not appear after auto-login")
        XCTAssertTrue(staffViewTitle.exists, "Staff view title should be visible")

        let app = XCUIApplication()
        app.terminate()
        app.launch()
        
        XCTAssertTrue(staffViewTitle.exists, "Staff view title should be visible")
    }
}
