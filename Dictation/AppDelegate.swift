import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSSpeechRecognizerDelegate {

	@IBOutlet weak var window: NSWindow!
	
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		let speech = NSSpeechRecognizer()!
		speech.delegate = self
		speech.commands = [
			"click", "double", "triple", "double copy", "copy", "trash", "delete",
			"email", "phone number",
		]
		speech.listensInForegroundOnly = false
		speech.startListening()
		
		
		// This property blocks dictation system wide. If it's not blocked, dictation occurs immediately after your command is performed and could have unintended effects. For example, if you double-click on a word by saying the command 'Double' the word will be double clicked on, but that word will be replaced by the word 'Double'. To use built-in dictation along with this program, you have two options that I'm aware of: First option (my preference), create custom dictation commands in system preferences > accessibility > dictation commands, using all the command you use in this program, and have them perform a shortcut that does nothing. Second option, set the blocksOtherRecognizers property on the instance of NSSpeechRecognizer to true as soon as the command is recognized in the delegate function, and set it to false at the end of the function after performing mouse/keyboard operations. (It works most of the time, but every once in a while, it does not block the built-in dictation).
		speech.blocksOtherRecognizers = true
	}
	

	// Delegate function
	func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String) {
		
		switch command {
		case "click":	Mouse.click()
		case "double": 	Mouse.click(2)
		case "triple":	Mouse.click(3)
		case "trash", "delete": Keyboard.tap("delete")
		case "copy": Keyboard.tap(key: "c", holdDown: .maskCommand)
		case "cake": Mouse.click(2); Keyboard.tap(key: "c", holdDown: .maskCommand) // double click, copy
		case "email": 	Keyboard.type("developer@digitalbananasapps.com")
		case "phone number": Keyboard.type("5551234567")
		default: break
		}
		
	}
	
}
