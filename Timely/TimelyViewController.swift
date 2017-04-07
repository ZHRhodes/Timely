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
	var timer: CountdownTimer = CountdownTimer()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		NotificationCenter.default.addObserver(self, selector: #selector(TimelyViewController.alarm), name: NSNotification.Name(Constants.strings.countdownZero), object: nil)
    }
	
	@IBAction func sliderChanged(_ sender: Any) {
		print("slider changed value \(slider.intValue)")
		timer.reset(withNewValue: Int(slider.intValue))
	}
	
	@IBAction func toggleTimer(_ sender: Any) {
		timer.toggleTimer()
	}
	
	func alarm(){
		print("done!!")
	}
}
