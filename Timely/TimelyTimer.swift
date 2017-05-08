//
//  TimelyTimer.swift
//  Timely
//
//  Created by Zack Rhodes on 4/11/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation

protocol TimelyTimer {
	func start()
	func stop()
	func reset()
}

protocol TimerUpdateDelegate: class {
	func timeUpdate(seconds: UInt)
}

protocol PomodoroTimerUpdateDelegate: class, TimerUpdateDelegate {
	func stateChange(newState: PomodoroState)
}
