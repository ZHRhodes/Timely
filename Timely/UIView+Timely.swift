//
//  UIView+Timely.swift
//  Timely
//
//  Created by Zack Rhodes on 5/7/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

protocol NSViewLoading {}
extension NSView : NSViewLoading {}

extension NSViewLoading where Self : NSView {
	static func loadFromNib() -> Self {
		let nibName = "\(self)".characters.split(separator: ".").map(String.init).last!
		let nib = NSNib(nibNamed: nibName, bundle: nil)
		return nib?.instantiate(withOwner: self, topLevelObjects: nil) as! Self
	}
}
