import Cocoa


struct Keyboard {
    
    // Key codes for symbols & keyboard shortcuts
    private static let symbols: [Character: (CGKeyCode, CGEventFlags)] = [
        "@": (19, .maskShift) ]
    
    
    // Key codes for characters
    private static let character: [Character: UInt16] = [
        "a": 0, "b": 11, "c": 8, "d": 2, "e": 14, "f": 3, "g": 5, "h": 4, "i": 34, "j": 38, "k": 40, "l": 37, "m": 46, "n": 45, "o": 31, "p": 35, "q": 12, "r": 15, "s": 1, "t": 17, "u": 32, "v": 9, "w": 13, "x": 7, "y": 16, "z": 6, "0": 29, "1": 18, "2": 19, "3": 20, "4": 21, "5": 23, "6": 22, "7": 26, "8": 28, "9": 25, ".": 47, ",": 43, "+": 69, "-": 78, "=": 81, "*": 67, "/": 75
    ]
    
    
    // Key codes special keys
    private static let key: [String: UInt16] = [
        "f1": 122, "f2": 120, "f3": 99, "f4": 118, "f5": 96, "f6": 97, "f7": 98, "f8": 100, "f9": 101, "f10": 109, "f11": 103, "f12": 111,
        "up": 126, "down": 125, "left": 123, "right": 124, "enter": 76, "home": 115, "end": 119, "pagedown": 121, "pageup": 116, "return": 36, "delete": 51, "tab": 48, "spacebar": 49, "shift": 56, "control": 59, "menu": 58, "escape": 53, "caps": 57, "help": 114, "fn": 63, "option": 58, "cmd": 55
    ]
    
    
    // Type a string of characters
    static func type(_ word: String) {
        // Iterate through word to get each character
        for c in word {
            if let key = character[c] { tap(key: key) }
            if let key = symbols[c] { tap(key: key.0, holdDown: key.1) }
        }
    }
    
    
    // Tap keyboard key using name
    static func tap(_ name: String) {
        if let key = key[name] {
            tap(key: key)
        }
    }
    
    
    // Tap keyboard key using keycode
    static func tap(key: CGKeyCode) {
        CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true)!.post(tap: .cghidEventTap)
        CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: false)!.post(tap: .cghidEventTap)
    }
    
    
    // Tap keyboard key while holding another key down using key name
    static func tap(key name: Character, holdDown: CGEventFlags) {
        guard let key = character[name] else { return }
        tap(key: key, holdDown: holdDown)
    }
    
    
    // Tap keyboard key while holding another key down using key code
    static func tap(key: CGKeyCode, holdDown: CGEventFlags) {
        guard let down = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true) else { return }
        down.flags = holdDown
        down.post(tap: .cghidEventTap)
        
        CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: false)!.post(tap: .cghidEventTap)
    }
    
}

