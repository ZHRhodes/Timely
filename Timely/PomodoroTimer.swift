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
		state.next()
		updateState()
	}
	
	func skipToPrevState(){
		if(timer != nil){
			if(timer!.isTimerJustStarting()){
				state.prev()
			}
		}
		updateState()
	}
	
	private func updateState(){
		let timerRunning = timer?.running ?? false
		stop()
		timer = nil
		delegate?.timeUpdate(seconds: state.getTime())
		if(timerRunning){
			start()
		}
	}
	
	func getTime()->TimeDuration {
		return TimeDuration(seconds: timer?.seconds ?? 0)
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
		stop()
		timer = nil
		delegate?.timeUpdate(seconds: state.getTime())
	}
}
