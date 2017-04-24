//
//  TimelyViewController.swift
//  Timely
//
//  Created by Zack Rhodes on 4/6/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

class TimelyViewController: NSViewController {

	@IBOutlet var slider: NSSlider!
	var timer: TimelyTimer?
	var running: Bool = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	@IBAction func sliderChanged(_ sender: Any) {
		print("slider changed value \(slider.intValue)")
		timer = nil
		running = false
	}
	
	@IBAction func toggleTimer(_ sender: Any) {
		if(running){
			timer?.stop()
		}else{
			if(timer == nil){
				timer = CountdownTimer(withTime: Int(slider.intValue))
				timer?.setDelegate(self)
			}
			timer?.start()
		}
		running = !running
	}
	
}

extension TimelyViewController: TimerUIDelegate {
	func timeUpdate(seconds:Int){
		slider.intValue = Int32(seconds)
	}
}
