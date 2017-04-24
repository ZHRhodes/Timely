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

struct Alarm {
	var player: AVAudioPlayer!
	var sound: AlarmSound!
	
	init(sound: AlarmSound) {
		self.sound = sound
	}
	
	init() {
		self.init(sound: AlarmSound.Glass)
	}
	
	mutating func playSound(){
		StatusItemManager.shared.showPopover(nil)
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
