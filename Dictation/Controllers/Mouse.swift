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
        var event: CGEvent!
        
        guard let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: Mouse.location, mouseButton: .left) else { return }
        event = mouseDown
        event.post(tap: .cghidEventTap)
        
        guard let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: Mouse.location, mouseButton: .left) else { return }
        event = mouseUp
        event.post(tap: .cghidEventTap)
        
        guard times > 1 else { return }
        
        for _ in 2...times {
            guard let mouseDown = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: Mouse.location, mouseButton: .left) else { return }
            event = mouseDown
            event.setIntegerValueField(.mouseEventClickState, value: times)
            event.post(tap: .cghidEventTap)
            
            guard let mouseUp = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: Mouse.location, mouseButton: .left) else { return }
            event = mouseUp
            event.setIntegerValueField(.mouseEventClickState, value: times)
            event.post(tap: .cghidEventTap)
        }
    }
    
}

