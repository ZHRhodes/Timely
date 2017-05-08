//
//  NSViewController+Timely.swift
//  Timely
//
//  Created by Zack Rhodes on 5/7/17.
//  Copyright © 2017 zhrhodes. All rights reserved.
//

import Cocoa

extension NSViewController {
	var isVisible: Bool {
		return self.isViewLoaded && self.view.window != nil
	}
}
