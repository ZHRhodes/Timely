//
//  PomodoroViewController.swift
//  Timely
//
//  Created by Zack Rhodes on 5/7/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

class PomodoroViewController: NSViewController {

	
	@IBOutlet var pomCompleteLabel: NSTextField!
	@IBOutlet var stateLabel: NSTextField!
	@IBOutlet var timeLabel: NSTextField!
	@IBOutlet var startButton: NSButtonCell!
	@IBOutlet var resetButton: NSButton!
	@IBOutlet var prevButton: NSButton!
	@IBOutlet var nextButton: NSButton!
	
	var running: Bool = false{ //add isRunning to timer
		willSet {
			if(newValue) {
				startButton.title = "Stop"
			}else{
				startButton.title = "Start"
			}
		}
	}
	
	var timer: PomodoroTimer!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		timer = PomodoroTimer()
		timer.setDelegate(self)
    }
	
	@IBAction func toggleTimer(_ sender: Any) {
		if(running){
			timer.stop()
		}else{
			timer.start()
			StatusItemManager.shared.setTime(timer.getTime())
		}
		running = !running
	}
	
	@IBAction func resetTimer(_ sender: Any) {
		running = false
		timer.reset()
	}
	
	@IBAction func prevTimerState(_ sender: Any) {
		timer.skipToPrevState()
	}
	
	@IBAction func nextTimerState(_ sender: Any) {
		timer.skipToNextState()
	}
	
	
}

extension PomodoroViewController: PomodoroTimerUpdateDelegate {
	func timeUpdate(seconds: UInt) {
		let td = TimeDuration(seconds: seconds)
		timeLabel.stringValue = td.compactDescription
		if(self.isVisible){
			StatusItemManager.shared.setTime(td)
		}
	}
	
	func stateChange(newState: PomodoroState) {
		stateLabel.stringValue = newState.getName()
		pomCompleteLabel.stringValue = newState.getPomComplete()
	}
}
