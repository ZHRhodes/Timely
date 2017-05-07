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
	var vc2: CountdownViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		vc1 = CountdownViewController(nibName: "CountdownViewController", bundle: nil)
		vc2 = CountdownViewController(nibName: "CountdownViewController", bundle: nil)
		tabView.tabViewItem(at: 0).view = vc1.view
		tabView.tabViewItem(at: 1).view = vc2.view
	}
	
	@IBAction func segmentTapped(_ sender: Any) {
		tabView.selectTabViewItem(at: tabs.selectedSegment)
	}
	
	
}
