//
//  TabContainer.swift
//  Timely
//
//  Created by Zack Rhodes on 5/6/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

class TabContainer: NSViewController {
	
	@IBOutlet var tabs: NSSegmentedCell!
	@IBOutlet var tabView: NSTabView!
	var vc1: CountdownViewController!
	var vc2: PomodoroViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		vc1 = CountdownViewController(nibName: "CountdownViewController", bundle: nil)
		vc2 = PomodoroViewController(nibName: "PomodoroViewController", bundle: nil)
		tabView.tabViewItem(at: 0).view = vc1.view
		tabView.tabViewItem(at: 1).view = vc2.view
		tabs.selectSegment(withTag: 1)
	}
	
	@IBAction func segmentTapped(_ sender: Any) {
		tabView.selectTabViewItem(at: tabs.selectedSegment)
	}
	
	@IBAction func exitPressed(_ sender: Any) {
		NSApplication.shared().terminate(self)
	}
}
