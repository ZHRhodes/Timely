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
	var player: AVAudioPlayer?
	var manager: TimelyStatusItemManager = StatusItemManager.shared
	var soundFilepath: URL!
	
	init(sound: AlarmSound? = nil, repeats: Bool = true) {
		initPlayer(sound: sound ?? AlarmSound.Glass, loops: repeats ? 1000 : 0)
	}
	
	mutating func initPlayer(sound: AlarmSound, loops: Int){
		let soundFilepath = URL(fileURLWithPath: Bundle.main.path(forResource: sound.rawValue, ofType: sound.getFileType())!)
		do {
			player = try AVAudioPlayer(contentsOf: soundFilepath, fileTypeHint: "mp3")
			player?.numberOfLoops = loops
		} catch {
			print("Error getting the audio file")
		}
	}
	
	mutating func playSound(){
		manager.showPopover(nil)
		player?.prepareToPlay()
		player?.play()
	}
	
	func stopSound() {
		player?.stop()
	}
	
}
