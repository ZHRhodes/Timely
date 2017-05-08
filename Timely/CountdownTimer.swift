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
	var alarm: TimelyAlarm?
	weak var delegate: TimerUpdateDelegate?
	var startTime: UInt!
	
	var seconds: UInt {
		willSet {
			delegate?.timeUpdate(seconds: newValue)
			if(newValue == 0){
				stop()
				alarm?.playSound()
			}
		}
	}
	
	var running: Bool = false {
		didSet {
			if(oldValue == false && running == true){
				timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
					print("ticktock \(self.seconds)")
					self.seconds = self.seconds > 0 ? self.seconds-1 : 0
				})
			}else if(oldValue == true && running == false){
				timer?.invalidate()
			}
		}
	}
	
	init(withTime time: UInt, alarm: TimelyAlarm?){
		startTime = time
		seconds = time
		self.alarm = alarm
	}
	
	func setDelegate(_ delegate: TimerUpdateDelegate){
		self.delegate = delegate
	}
}

extension CountdownTimer : TimelyTimer {
	
	func start(){
		running = true
	}
	
	func stop(){
		running = false
		alarm?.stopSound()
	}
	
	func reset(){
		stop()
		seconds = startTime
	}

}
