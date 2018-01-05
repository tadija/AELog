# AELog
**Simple, lightweight and flexible debug logging framework written in Swift**

[![Language Swift 4.0](https://img.shields.io/badge/Language-Swift%204.0-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS | watchOS | tvOS | OSX](https://img.shields.io/badge/Platforms-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20OS%20X-lightgray.svg?style=flat)](http://www.apple.com)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/tadija/AELog/blob/master/LICENSE)

[![CocoaPods Version](https://img.shields.io/cocoapods/v/AELog.svg?style=flat)](https://cocoapods.org/pods/AELog)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

If you find yourself in upcoming statements, then you probably want to use **AELog**:  
> - I just want to log anything to console while working on a project, then turn it off when going live.  
> - I'd like to enable / disable logging on a file level, and also to format log lines just the way I like.  
> - I don't want to have anything other then that, I just want to be up and running in no time.

## Index
- [Features](#features)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)

## Features
- **Top level logging** which can be disabled when needed
- Enable or disable logging **on a file level**
- **Customizable format and verbosity** of log lines

## Usage

```swift
/// Log Message (write less, get more)

log(message: "hi there")

/// For example, if you added this on line 21 in `viewDidLoad` of your `ViewController`, this is how your output might look:
/// 2016-04-03 21:08:00.123 -- [Main] ViewController (21) -> viewDidLoad() > hi there

/// Log Elements (if you just want to quickly log some interesting variables at the moment)

let x: CGFloat = 21
let y: CGFloat = 8
let size = CGSize(width: 19, height: 84)
let rect = CGRect(x: x, y: y, width: size.width, height: size.height)

log(elements: x, y, size, rect)

/// Log Settings

let settings = Log.shared.settings
settings.isEnabled = true
settings.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
settings.template = "{date} -- [{thread}] {file} ({line}) -> {function} > {message}"

/// - Note: you can toggle logging for specific files like this:
settings.files = [
    "AppDelegate" : false,
    "ViewController" : true
]

/// LogDelegate

Log.shared.delegate = self

func didLog(line: Line) {
    /// do something here?
}
```

### One more thing

Have you ever wanted to see the output of your app while you're not at your computer, like in real time directly on your iOS device? Yeah, me neither, but just in case you change your mind (like I did), check out [AEConsole](https://github.com/tadija/AEConsole) - **customizable console UI overlay with debug log on top of your iOS app**. After all, `AELog` was made just to complement `AEConsole`. :)

## Installation

- [Swift Package Manager](https://swift.org/package-manager/):

    ```
    .Package(url: "https://github.com/tadija/AELog.git", majorVersion: 0)
    ```

- [Carthage](https://github.com/Carthage/Carthage):

	```ogdl
	github "tadija/AELog"
	```

- [CocoaPods](http://cocoapods.org/):

	```ruby
	pod 'AELog'
	```

## License
AELog is released under the MIT license. See [LICENSE](LICENSE) for details.
