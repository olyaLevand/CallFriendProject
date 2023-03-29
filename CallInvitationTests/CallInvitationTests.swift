//
//  CallInvitationTests.swift
//  CallInvitationTests
//
//  Created by оля on 23.05.2022.
//

import XCTest
@testable import CallFriendProject
import NotificationCenter


class CallInvitationTests: XCTestCase {

    
    var user1CallViewModel: MainViewModel? = nil
    var user2CallViewModel: MainViewModel? = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUser1LogIn() async {
        
        // Prepare Data
        let dataCollector = DataCollector()
        let user1login = LoginViewModel(dataCollector: dataCollector)
        let username = "User1"

        let res = await user1login.login(username: username)
        let result = try? XCTUnwrap(user1login.dataCollector.isLoggedIn)
        XCTAssertEqual(result, true)
    }
    
    
    
    func testUser2LogIn() async {
        // Prepare Data
        let dataCollector = DataCollector()
        let user1login = LoginViewModel(dataCollector: dataCollector)
        let username = "User2"

        let res = await user1login.login(username: username)
        let result = try? XCTUnwrap(user1login.dataCollector.isLoggedIn)
        XCTAssertEqual(res, true)
    }
    
    func testStartCallWithDecline() throws {
         // Arrange
//        callInviteVM.sendInvitation(to: <#T##String#>, callType: <#T##Call.CallType#>)
        
//         // Act
//         expectation = expectation(description: "Temperature updates") // 3
//         manager.startUpdating()
//
//         // Assert
//         waitForExpectations(timeout: 1) // 4
//
//         let result = try XCTUnwrap(temperature)
//         XCTAssertEqual(result, 0) // 5
     }
    
    
    func testStartCallWithAccept() throws {
//         // Arrange
//        callInviteVM.sendInvitation(to: <#T##String#>, callType: <#T##Call.CallType#>)
//         // Act
//         expectation = expectation(description: "Temperature updates") // 3
//         manager.startUpdating()
//
//         // Assert
//         waitForExpectations(timeout: 1) // 4
//
//         let result = try XCTUnwrap(temperature)
//         XCTAssertEqual(result, 0) // 5
     }
    
    func testCallhangUp(){
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
