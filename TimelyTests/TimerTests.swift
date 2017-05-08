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
		countdownTimer = CountdownTimer(withTime: 10, alarm: Alarm(sound: AlarmSound.Glass))
    }
    
    override func tearDown() {
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
	
	func testStopStopsAlarm() {
		let alarmSpy = AlarmSpy()
		countdownTimer = CountdownTimer(withTime: 1, alarm: alarmSpy)
		countdownTimer.stop()
		XCTAssert(alarmSpy.didStopSound == true)
	}
	
	func testResetStopAlarmAndResetsTime() {
		let startTime = countdownTimer.startTime
		countdownTimer.start()
		countdownTimer.reset()
		XCTAssert(countdownTimer.running == false)
		XCTAssert(countdownTimer.seconds == startTime)
		
	}
	
	func testSettingUIDelegateAndUpdatingWithNewTime() {
		let delegateSpy = TimerUpdateDelegateSpy()
		let newTime: UInt = 1
		countdownTimer.setDelegate(delegateSpy)
		XCTAssert(countdownTimer.delegate != nil)
		countdownTimer.seconds = newTime
		XCTAssert(delegateSpy.timeHasBeenUpdated == true)
		XCTAssert(delegateSpy.currentTime == newTime)
	}

	func testActivatedTimerGoesToZeroAndTriggersAlarm() {
		let alarmSpy = AlarmSpy()
		let time: UInt = 1
		countdownTimer = CountdownTimer(withTime: time, alarm: alarmSpy)
		let pr = NSPredicate(format: "didPlaySound == true")
		expectation(for: pr, evaluatedWith: alarmSpy, handler: nil)
		countdownTimer.start()
		waitForExpectations(timeout: TimeInterval(time)) { (error) in
			if (error != nil) {
				print("Timer did not reach zero and/or trigger alarm")
			}
		}
	}
	
	func testStartingTimerSetsTimerWithOneSecondInterval() {
		countdownTimer.start()
		XCTAssert(countdownTimer.timer != nil)
		XCTAssert(countdownTimer.timer?.isValid == true)
		XCTAssert(countdownTimer.timer?.timeInterval == 1.0)
	}
	
	func testStoppingTimerInvalidatesAlarm() {
		countdownTimer.start()
		countdownTimer.stop()
		XCTAssert(countdownTimer.timer?.isValid == false)
	}
	
	
	
	class AlarmSpy: NSObject, TimelyAlarm {
		private(set) var didPlaySound = false
		private(set) var didStopSound = false
		
		func playSound(){
			didPlaySound = true
		}
		
		func stopSound(){
			didStopSound = true
		}
	}
	
	class TimerUpdateDelegateSpy: TimerUpdateDelegate {
		private(set) var timeHasBeenUpdated = false
		private(set) var currentTime: UInt = 0
		
		func timeUpdate(seconds: UInt) {
			timeHasBeenUpdated = true
			currentTime = seconds
		}
	}

}
