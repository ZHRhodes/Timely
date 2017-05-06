//
//  AlarmTests.swift
//  Timely
//
//  Created by Zack Rhodes on 4/23/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import XCTest
@testable import Timely

class AlarmTests: XCTestCase {
	
	var alarm: Alarm!
	
    override func setUp() {
        super.setUp()
		alarm = Alarm(sound: AlarmSound.SomeoneNew)
    }
    
    override func tearDown() {
        super.tearDown()
		alarm = nil
    }

	func testEmptyInitializerSetsSoundToGlass() {
		alarm = Alarm()
		alarm.playSound()
		XCTAssert(alarm.sound == AlarmSound.Glass)
	}
	
	func testPlaySoundShowsPopover() {
		let managerSpy = StatusItemManagerSpy()
		alarm.manager = managerSpy
		alarm.playSound()
		XCTAssert(managerSpy.popoverIsShown == true)
	}
	
	func testPlayingAlarmSetsAndStartsPlayer() {
		alarm.playSound()
		XCTAssert(alarm.player != nil)
		XCTAssert(alarm.player.numberOfLoops == 1000)
		XCTAssert(alarm.player.isPlaying == true)
	}
	
	func testStoppingSoundsStopsPlayer() {
		alarm.playSound()
		XCTAssert(alarm.player.isPlaying == true)
		alarm.stopSound()
		XCTAssert(alarm.player.isPlaying == false)
	}

	class StatusItemManagerSpy: TimelyStatusItemManager {
		private(set) var popoverIsShown = false
		private(set) var curTime: TimeDuration = TimeDuration(seconds: 100)
		
		func togglePopover(sender: AnyObject?) {
			popoverIsShown = !popoverIsShown
		}
		
		func closePopover(_ sender: AnyObject?) {
			popoverIsShown = false
		}
		
		func showPopover(_ sender: AnyObject?) {
			popoverIsShown = true
		}
		
		func setTime(_ time: TimeDuration) {
			curTime = time
		}
		
	}
}
