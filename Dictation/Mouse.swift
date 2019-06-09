import Cocoa


struct Mouse {
	
	
	/// Location of Mouse pointer
	private static var location: CGPoint {
		
		var ml = NSEvent.mouseLocation
		ml.y = NSHeight(NSScreen.screens[0].frame) - ml.y
		
		return CGPoint(x: ml.x, y: ml.y)
	}
	
	
	/// Clicks left mouse button
	static func click(_ times: Int64 = 1) {
		
		var e = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: Mouse.location, mouseButton: .left)!
		e.post(tap: .cghidEventTap)
		e = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: Mouse.location, mouseButton: .left)!
		e.post(tap: .cghidEventTap)
		
		guard times > 1 else { return	}

		for _ in 2...times {
			e = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: Mouse.location, mouseButton: .left)!
			e.setIntegerValueField(.mouseEventClickState, value: times)
			e.post(tap: .cghidEventTap)
			
			e = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: Mouse.location, mouseButton: .left)!
			e.setIntegerValueField(.mouseEventClickState, value: times)
			e.post(tap: .cghidEventTap)
		}
	}
	
}

