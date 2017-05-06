//
//  CountdownViewController.swift
//  Timely
//
//  Created by Zack Rhodes on 4/11/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

class CountdownViewController: NSViewController {

	@IBOutlet var hours: NSTextField!
	@IBOutlet var minutes: NSTextField!
	@IBOutlet var seconds: NSTextField!

	@IBOutlet var toggleButton: NSButton!
	
	var timer: TimelyTimer?
	var running: Bool = false {
		willSet {
			if(newValue){
				toggleTextFields(enabled: false)
				toggleButton.title = "Stop"
			}else{
				toggleTextFields(enabled: true)
				toggleButton.title = "Start"
			}
		}
	}

	var time: TimeDuration {
		let hoursNum = createIntFromNumbers(inString: self.hours.stringValue)
		let minutesNum = createIntFromNumbers(inString: self.minutes.stringValue)
		let secondsNum = createIntFromNumbers(inString: self.seconds.stringValue)
		return TimeDuration(hours: hoursNum, minutes: minutesNum, seconds: secondsNum)
	}
	
	override func viewDidAppear() {
		hours.becomeFirstResponder()
	}
	
	@IBAction func toggleTimer(_ sender: Any) {
		if(running){
			timer?.stop()
			timer = nil
		}else{
			if(timer == nil){
				timer = CountdownTimer(withTime: time.toSeconds(), alarm: Alarm(sound: AlarmSound.Basso))
				timer?.setDelegate(self)
			}
			timer?.start()
		}
		running = !running
	}
	
	func toggleTextFields(enabled: Bool){
		hours.isEnabled = enabled
		minutes.isEnabled = enabled
		seconds.isEnabled = enabled
	}
	
	func createIntFromNumbers(inString str: String) -> UInt {
		let ret = UInt(str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: ""))
		return ret != nil ? ret! : 0
	}
}

extension CountdownViewController: TimerUIDelegate {
	func timeUpdate(seconds: UInt) {
		let td = TimeDuration(seconds: seconds)
		self.hours.stringValue = String(describing: td.hours)
		self.minutes.stringValue = String(describing: td.minutes)
		self.seconds.stringValue = String(describing: td.seconds)
		StatusItemManager.shared.setTime(td)
		
	}
}
