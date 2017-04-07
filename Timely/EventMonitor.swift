//
//  EventMonitor.swift
//  Timely
//
//  Created by Zack Rhodes on 4/6/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

class EventMonitor {
	private var monitor: Any?
	private let mask: NSEventMask
	private let handler: (NSEvent?) -> ()
	
	public init(mask: NSEventMask, handler: @escaping (NSEvent?) -> ()) {
		self.mask = mask
		self.handler = handler
	}
	
	deinit {
		stop()
	}
	
	public func start() {
		monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
	}
	
	public func stop() {
		if monitor != nil {
			NSEvent.removeMonitor(monitor!)
			monitor = nil
		}
	}
}
