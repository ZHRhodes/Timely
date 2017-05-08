//
//  PomodoroState.swift
//  Timely
//
//  Created by Zack Rhodes on 5/7/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation

enum PomodoroState {
	case work1, sbreak1, work2, sbreak2, work3, sbreak3, work4, lbreak
	
	func getTime()->UInt {
		switch self {
		case .work1, .work2, .work3, .work4: return 1500
		case .sbreak1, .sbreak2, .sbreak3: return 300
		case .lbreak: return 1200
		}
	}
	
	func getName()->String {
		switch self {
		case .work1, .work2, .work3, .work4: return "Work"
		case .sbreak1, .sbreak2, .sbreak3: return "Short Break"
		case .lbreak: return "Long Break"
		}
	}
	
	func getPomComplete()->String {
		switch self{
		case .work1 : return ""
		case .sbreak1, .work2 : return "✔"
		case .sbreak2, .work3 : return "✔✔"
		case .sbreak3, .work4 : return "✔✔✔"
		case .lbreak : return "✔✔✔✔"
		}
	}
	
	mutating func next(){
		switch self {
		case .work1:   self = .sbreak1
		case .sbreak1: self = .work2
		case .work2:   self = .sbreak2
		case .sbreak2: self = .work3
		case .work3:   self = .sbreak3
		case .sbreak3: self = .work4
		case .work4:   self = .lbreak
		case .lbreak:  self = .work1
		}
	}
	
	mutating func prev(){
		switch self{
		case .work1:   self = .lbreak
		case .sbreak1: self = .work1
		case .work2:   self = .sbreak1
		case .sbreak2: self = .work2
		case .work3:   self = .sbreak2
		case .sbreak3: self = .work3
		case .work4:   self = .sbreak3
		case .lbreak:  self = .work4
		}
	}
}
