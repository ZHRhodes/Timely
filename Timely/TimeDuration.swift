//
//  TimeDuration.swift
//  Timely
//
//  Created by Zack Rhodes on 4/11/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation

struct TimeDuration {
	var hours, minutes, seconds: UInt
	
	init( hours: UInt, minutes: UInt, seconds: UInt){
		self.hours = hours
		self.hours += minutes/60
		self.minutes = minutes%60
		self.minutes += seconds/60
		self.seconds = seconds%60
	}
	
	init( seconds: UInt){
		var s = seconds
		self.hours = s/3600
		s %= 3600
		self.minutes = s/60
		s %= 60
		self.seconds = s
	}
	
	func toSeconds() -> UInt{
		return hours*3600 + minutes*60 + seconds
	}
}
