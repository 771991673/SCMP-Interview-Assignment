//
//  StaffViewUITests.swift
//  SCMP_Assignment
//
//  Created by James on 3/8/2025.
//

import XCTest


class StaffViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        try loginWorkflow()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func loginWorkflow() throws {
        
        let staffViewTitle = app.staticTexts["staffViewTitle"]
        if !staffViewTitle.exists {
            let emailTextField = app.textFields["emailTextField"]
            emailTextField.tap()
            emailTextField.typeText("eve.holt@reqres.in")
            
            let passwordTextField = app.secureTextFields["passwordTextField"]
            passwordTextField.tap()
            passwordTextField.typeText("cityslicka")
            
            let loginButton = app.buttons["loginButton"]
            loginButton.tap()
        }
    }
    
    
    func testAutoLogin() throws {
        let staffViewTitle = app.staticTexts["staffViewTitle"]
        XCTAssertTrue(staffViewTitle.waitForExistence(timeout: 20), "Staff view did not appear after auto-login")
        XCTAssertTrue(staffViewTitle.exists, "Staff view title should be visible")
    }
    
    func testStaffListPopulated() throws {
        
        let list = app.tables["staffList"]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            XCTAssertTrue(list.exists, "Staff list should be displayed")
            XCTAssertGreaterThan(list.cells.count, 0, "Staff list should contain at least one staff member")
            
            let firstStaffCell = list.cells.element(boundBy: 0)
            XCTAssertTrue(firstStaffCell.staticTexts["staffFirstName_1"].exists, "First name 'George' should be displayed")
            XCTAssertTrue(firstStaffCell.staticTexts["staffLastName_1"].exists, "Last name 'Bluth' should be displayed")
            XCTAssertTrue(firstStaffCell.staticTexts["staffEmail_1"].exists, "Email 'george.bluth@reqres.in' should be displayed")
        }
        
    }
    
    func testLoadMoreButton() throws {
        
        let list = app.tables["staffList"]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            XCTAssertTrue(list.exists, "Staff list should be displayed")
            
            while !self.app.buttons["loadMoreButton"].isHittable {
                list.swipeUp()
            }
            
            let loadMoreButton = self.app.buttons["loadMoreButton"]
            XCTAssertTrue(loadMoreButton.isHittable, "Load More button should be visible and hittable after scrolling to the bottom")
            
            loadMoreButton.tap()
            
            let alertText = self.app.staticTexts["toastText"]
            XCTAssertEqual(alertText.label, "Reach the maximum page", "The text view does not contain the expected text")
        }
    }
}

