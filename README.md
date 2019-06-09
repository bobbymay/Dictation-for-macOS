# Speech Recognition for macOS

Define words, phrases, or sentences to perform keyboard and mouse operations.

I made this because Dragon Dictation software is no longer supported on macOS, and the built-in dictation lacks the ability to perform mouse clicks and certain keyboard functions.

This can be used in conjunction with Apple's built-in dictation, but you will need to read the section below.

#### Setup
```swift
let speech = NSSpeechRecognizer()!
speech.delegate = self
speech.commands = [
 "click", "double", "triple", "copy", "double copy", "trash", "delete",
 "email", "phone number",
]
speech.listensInForegroundOnly = false
speech.startListening()
```
#### Conform to delegate to receive word, phrase, or sentence
```swift
func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String) {

 switch command {
  case "click": 
   Mouse.click()
  case "double": 
   Mouse.click(2)
  case "triple": 
   Mouse.click(3)
  case "trash", "delete":
   Keyboard.tap("delete")
  case "copy": 
   Keyboard.tap(key: "c", holdDown: .maskCommand)
  case "double copy":
   Mouse.click(2)
   Keyboard.tap(key: "c", holdDown: .maskCommand)  
  case "email":
   Keyboard.type("developer@digitalbananasapps.com")
  case "phone number": 
   Keyboard.type("555.123.4567")
  default: break
 }

}
```
## To use with Apple's built-in dictation
The property blocksOtherRecognizers of NSSpeechRecognizer blocks dictation system wide. If this property is not true, dictation occurs immediately after your command is performed and could have unintended effects. For example, if you double-click on a word by saying the command 'Double' the word will be double clicked on, but that word will be replaced by the word 'Double'. 

You have two options to avoid this: 

First option, create custom dictation commands in system preferences > accessibility > dictation commands, using all the commands you use in this program, and have them perform a shortcut that does nothing. (my preference)

Second option, set the blocksOtherRecognizers property on the instance of NSSpeechRecognizer to true as soon as the command is recognized in the delegate function, and set it to false at the end of the function after performing mouse/keyboard operations. (It works most of the time, but every once in a while, it does not block the built-in dictation)
```swift
func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String) {

 speech.blocksOtherRecognizers = true

 switch command {
  case "click":	
   Mouse.click()
  case "double": 
   Mouse.click(2)
  case "triple":	
   Mouse.click(3)
  default: break
 }

 speech.blocksOtherRecognizers = false

}
```
