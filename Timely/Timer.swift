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
	var alarm: Alarm!
	weak var delegate: TimerUIDelegate?
	var startTime: Int!
	
	var seconds: Int {
		willSet {
			delegate?.timeUpdate(seconds: newValue)
			if(newValue <= 0){
				stop()
				alarm = Alarm()
				alarm?.playSound()
			}
		}
	}
	
	var running: Bool = false {
		didSet {
			if(oldValue == false && running == true){
				timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
					print("ticktock \(self.seconds)")
					self.seconds -= 1
				})
			}else if(oldValue == true && running == false){
				timer?.invalidate()
			}
		}
	}
	
	init(withTime: Int){
		startTime = withTime
		seconds = withTime
	}
	
}

extension CountdownTimer : TimelyTimer {
	
	func start(){
		running = true
	}
	
	func stop(){
		running = false
		if let _ = alarm {
			alarm?.stopSound()
		}
	}
	
	func reset(){
		stop()
		seconds = startTime
	}
	
	func setDelegate(_ delegate: TimerUIDelegate){
		self.delegate = delegate
	}
}

extension CountdownTimer : CustomStringConvertible {
	var description: String {
		return String(describing: seconds)
	}
}
