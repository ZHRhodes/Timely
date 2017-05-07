//
//  TabContainer.swift
//  Timely
//
//  Created by Zack Rhodes on 5/6/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

class TabContainer: NSTabViewController {
	
	@IBOutlet var tabs: NSTabView!
	@IBOutlet var countdownTabItem: NSTabViewItem!
	@IBOutlet var pomodoroTabItem: NSTabViewItem!
	var vc1: CountdownViewController!
	var vc2: CountdownViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		vc1 = CountdownViewController(nibName: "CountdownViewController", bundle: nil)
		vc2 = CountdownViewController(nibName: "CountdownViewController", bundle: nil)
		countdownTabItem.view = vc1?.view
		pomodoroTabItem.view = vc2?.view
		
	}
}
