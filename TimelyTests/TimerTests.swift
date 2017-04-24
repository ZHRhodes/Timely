//
//  TimerTests.swift
//  Timely
//
//  Created by Zack Rhodes on 4/21/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import XCTest
@testable import Timely

class TimerTests: XCTestCase {

	var countdownTimer: CountdownTimer!
	
    override func setUp() {
        super.setUp()
		countdownTimer = CountdownTimer(withTime: 10)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		countdownTimer = nil
    }
	
	func testStartSetsTimerToRunning() {
		countdownTimer.running = false
		countdownTimer.start()
		XCTAssert(countdownTimer.running == true)
	}
	
	func testStopSetsTimerToNotRunning() {
		countdownTimer.running = true
		countdownTimer.stop()
		XCTAssert(countdownTimer.running == false)
	}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
