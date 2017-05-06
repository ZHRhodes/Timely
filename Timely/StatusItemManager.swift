//
//  StatusItemManager.swift
//  Timely
//
//  Created by Zack Rhodes on 4/12/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Foundation
import Cocoa

protocol TimelyStatusItemManager {
	func togglePopover(sender: AnyObject?)
	func closePopover(_ sender: AnyObject?)
	func showPopover(_ sender: AnyObject?)
	func setTime(_ time: TimeDuration)
}

class StatusItemManager: NSObject, TimelyStatusItemManager {
	static let shared = StatusItemManager()
	
	let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
	let popover = NSPopover()
	var eventMonitor: EventMonitor?
	
	private override init(){
		super.init()
		if let button = statusItem.button {
			button.action = #selector(AppDelegate.togglePopover(sender:))
			button.title = "00:00:00"
		}
		
		
		popover.contentViewController = CountdownViewController(nibName: "CountdownViewController", bundle: nil)
		
		eventMonitor = EventMonitor(mask: .leftMouseDown, handler: { [weak self] (event) in
			if let isShown = (self?.popover.isShown){
				if(isShown){
					self?.closePopover(event)
				}
			}
		})
		eventMonitor?.start()
		
	}
	
	func togglePopover(sender: AnyObject?){
		if(popover.isShown){
			closePopover(sender)
		}else{
			showPopover(sender)
		}
	}
	
	func closePopover(_ sender: AnyObject?){
		popover.performClose(sender)
		eventMonitor?.stop()
	}
	
	func showPopover(_ sender: AnyObject?){
		if let button = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
		}
		eventMonitor?.start()
	}
	
	
	func setTime(_ time: TimeDuration){
		if let button = statusItem.button{
			button.title = "\(String(format: "%02d", time.hours)):\(String(format: "%02d", time.minutes)):\(String(format: "%02d", time.seconds))"
		}
	}
}
