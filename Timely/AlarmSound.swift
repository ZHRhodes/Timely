//
//  AlarmSound.swift
//  Timely
//
//  Created by Zack Rhodes on 4/11/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation

enum  AlarmSound: String {
	case SomeoneNew = "SomeoneNew"
	case Ping = "Ping"
	case Glass = "Glass"
	case Basso = "Basso"
	
	func getFileType()->String{
		switch self {
		case .SomeoneNew:
			return "mp3"
		default:
			return "aiff"
		}
	}
}
