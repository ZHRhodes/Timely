//
//  Timer.swift
//  Timely
//
//  Created by Zack Rhodes on 4/7/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation

class CountdownTimer {
	
	var timer: Timer?

	var seconds: Int = Constants.nums.defaultTimerValue {
		didSet{
			if(oldValue <= 0){
				running = false
				NotificationCenter.default.post(name: NSNotification.Name(Constants.strings.countdownZero), object: nil)
			}
		}
	}
	
	var running: Bool = false {
		willSet {
			timer?.invalidate()
			if(newValue){
				timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
					print("ticktock \(self.seconds)")
					self.seconds -= 1
				})
			}
		}
	}
	
	func startTimer(withInitialValue value: Int){
		seconds = value
		running = true
	}
	
	func reset(withNewValue value: Int) {
		running = false
		seconds = value
	}
	
	func stopTimer(){
		running = false
	}
	
	func toggleTimer(){
		running = !running
	}
	
}

extension CountdownTimer : CustomStringConvertible {
	var description: String {
		return String(describing: seconds)
	}
}
