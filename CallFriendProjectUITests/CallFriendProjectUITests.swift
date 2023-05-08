//
//  CallFriendProjectUITests.swift
//  CallFriendProjectUITests
//
//  Created by Olya Levandivska on 07.04.2023.
//

import XCTest

final class CallFriendProjectUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
   
    func testLoginViewShouldNotSignIn() {
        let textFiled = app.textFields[" Enter username "]
        let loginButton = app.buttons["Log in"]
        let alert = app.alerts["Please, enter username"]
        let alertOkButton = alert.scrollViews.otherElements.buttons["OK"]
        let laabelText = app.staticTexts["Log In"]
        
        loginButton.tap()
        XCTAssertTrue(alert.exists)
        
        alertOkButton.tap()
        XCTAssertFalse(alert.exists)
    }
    
    func testLoginViewShouldSignIn(){
        let app = XCUIApplication()
        let textField = app.textFields[" Enter username "]
        let keyA = app.keys["A"]
        let loginButton = app.buttons["Log in"]
        
        textField.tap()
        keyA.tap()
        loginButton.tap()
                
        let newViewLabelText = "Hello, A"
        let helloOlyaStaticText = app.staticTexts[newViewLabelText]
        
        XCTAssertTrue(helloOlyaStaticText.exists)
    }    
     
    func testMainViewAlert(){
        
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
