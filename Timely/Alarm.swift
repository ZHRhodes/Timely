//
//  Alarm.swift
//  Timely
//
//  Created by Zack Rhodes on 4/8/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation
import AVFoundation
import Cocoa

protocol TimelyAlarm {
	mutating func playSound()
	func stopSound()
}

struct Alarm: TimelyAlarm {
	var player: AVAudioPlayer!
	var sound: AlarmSound!
	var manager: TimelyStatusItemManager = StatusItemManager.shared
	
	init(sound: AlarmSound? = nil) {
		self.sound = sound ?? AlarmSound.Glass
	}
	
	mutating func playSound(){
		manager.showPopover(nil)
		let soundFilepath = URL(fileURLWithPath: Bundle.main.path(forResource: sound.rawValue, ofType: sound.getFileType())!)
		do {
			player = try AVAudioPlayer(contentsOf: soundFilepath, fileTypeHint: "mp3")
			player.numberOfLoops = 1000
			player.prepareToPlay()
			player.play()
		} catch {
			print("Error getting the audio file")
		}
	}
	
	func stopSound() {
		player?.stop()
	}
	
}
