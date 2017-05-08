//
//  PomodoroTimer.swift
//  Timely
//
//  Created by Zack Rhodes on 5/7/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation

class PomodoroTimer {
	var state: PomodoroState {
		didSet {
			self.delegate?.stateChange(newState: state)
		}
	}
	var timer: CountdownTimer?
	lazy var alarm: Alarm = Alarm(repeats: false)
	weak var delegate: PomodoroTimerUpdateDelegate?
	
	init(){
		state = .work1
	}

	
	func setDelegate(_ delegate: PomodoroTimerUpdateDelegate){
		self.delegate = delegate
		self.delegate?.timeUpdate(seconds: state.getTime())
		self.delegate?.stateChange(newState: state)
	}
	
	func skipToNextState(){
		stop()
		timer = nil
		state.next()
		delegate?.timeUpdate(seconds: state.getTime())
	}
	
	func skipToPrevState(){
		stop()
		timer = nil
		state.prev()
		delegate?.timeUpdate(seconds: state.getTime())
	}
	
}

extension PomodoroTimer : TimerUpdateDelegate {
	func timeUpdate(seconds: UInt) {
		delegate?.timeUpdate(seconds: seconds)
		if(seconds == 0){
			timer = nil
			state.next()
			start()
		}
	}
}

extension PomodoroTimer : TimelyTimer {
	func start(){
		if(timer != nil){
			timer?.start()
		}else{
			timer = CountdownTimer(withTime: state.getTime(), alarm: alarm)
			timer?.setDelegate(self)
			timer?.start()
		}
	}
	
	func stop(){
		timer?.stop()
	}
	
	func reset(){
		state = .work1
		timer = nil
		delegate?.timeUpdate(seconds: state.getTime())
	}
}
