//
// RocketLaunchDemoTests.swift
// RocketLaunchDemoTests
//
// Created on 5.03.2022.
// Oguzhan Yalcin
//
//
//


import XCTest
@testable import RocketLaunchDemo

class RocketLaunchDemoTests: XCTestCase {

    func testHandleFormattedDate() {
        let date = "1997-09-23T12:30:00.000Z".toDate()
        let dateString = date.toString(formatType: "dd-MM-yyyy")
        
        XCTAssertEqual(dateString, "23-09-1997")
    }
    
    func testRequestRocketLaunchesAPI() {
        ServiceManager.shared.getRocketLaunches(parameters: nil) { (response, isOK) in
            
            XCTAssertNotNil(response)
            XCTAssertTrue(isOK)
        }
    }
    
    func testRequestRocketLaunchesUpcomingAPI() {
        ServiceManager.shared.getRocketLaunchesUpcoming(parameters: nil) { (response, isOK) in
            
            XCTAssertNotNil(response)
            XCTAssertTrue(isOK)
        }
    }
}
