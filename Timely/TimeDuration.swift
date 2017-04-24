//
//  TimeDuration.swift
//  Timely
//
//  Created by Zack Rhodes on 4/11/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation

struct TimeDuration {
	var hours, minutes, seconds: Int
	
	init( hours: Int, minutes: Int, seconds: Int){
		self.hours = hours
		self.minutes = minutes
		self.seconds = seconds
	}
	
	init( seconds: Int){
		var s = seconds
		self.hours = s/3600
		s %= 3600
		self.minutes = s/60
		s %= 60
		self.seconds = s
	}
	
	func toSeconds() -> Int{
		return hours*3600 + minutes*60 + seconds
	}
}
