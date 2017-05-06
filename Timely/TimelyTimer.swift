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
	func setDelegate(_ delegate: TimerUIDelegate)
}

protocol TimerUIDelegate: class {
	func timeUpdate(seconds: UInt)
}
