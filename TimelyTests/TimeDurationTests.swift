//
//  TimeDurationTests.swift
//  Timely
//
//  Created by Zack Rhodes on 4/24/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import XCTest
@testable import Timely

class TimeDurationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	func testInitalizerHandlesOverflowingComponents(){
		let td = TimeDuration(hours: 34, minutes: 2345, seconds: 800)
		XCTAssert(td.hours == 73)
		XCTAssert(td.minutes == 18)
		XCTAssert(td.seconds == 20)
	}
	
	func testSecondInitalizerCalculatesComponents() {
		let td = TimeDuration(seconds: 134523)
		XCTAssert(td.hours == 37)
		XCTAssert(td.minutes == 22)
		XCTAssert(td.seconds == 3)
	}

	func testToSeconds(){
		let td1 = TimeDuration(hours: 34, minutes: 2345, seconds: 800)
		let td2 = TimeDuration(seconds: td1.toSeconds())
		XCTAssert(td1.hours == td2.hours)
		XCTAssert(td1.minutes == td2.minutes)
		XCTAssert(td1.seconds == td2.seconds)
	}

}
