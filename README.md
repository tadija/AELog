# AELog
**Simple, lightweight and flexible debug logging minion written in Swift**

[![Language Swift 4.2](https://img.shields.io/badge/Language-Swift%204.2-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS | watchOS | tvOS | macOS](https://img.shields.io/badge/Platforms-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS-lightgray.svg?style=flat)](http://www.apple.com)
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
/// Log detailed debugging information with a simple one liner:

aelog()

/// - Note: if this was on line 21 in `viewDidLoad` of a `ViewController`, output could look like this:
/// 2016-04-03 21:08:00.123 -- [Main] ViewController (21) -> viewDidLoad() >

/// Add custom text to log line:

aelog("hi there")

/// Log random items (some interesting variables at the moment)

let text = "One two three four five"
let x: CGFloat = 21
let y: CGFloat = 8
let size = CGSize(width: 19, height: 84)
let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
let range = 1...5

aelog(text, x, y, size, rect, range, Log.shared, self)

/// - Note: in this case output could look like this:
/// 04:01:05.967 -- ViewController (30) -> viewDidAppear > 

/// #0: String | "One two three four five"
/// #1: Double | 21.0
/// #2: Double | 8.0
/// #3: CGSize | (19.0, 84.0)
/// #4: CGRect | (21.0, 8.0, 19.0, 84.0)
/// #5: CountableClosedRange<Int> | CountableClosedRange(1...5)
/// #6: Log | AELog.Log
/// #7: ViewController | <AELogDemo_iOS.ViewController: 0x7fd14c41dd60>

/// Log both to debugger and device console:

aelog("this should be logged just in case...", mode: .nsLog)

/// Log Settings

/// Enable or disable logging with one flag and customize formatting as you like.
/// - Warning: `aelog` will by default work only if logging is enabled and file is not disabled in settings,
/// otherwise it will do nothing, but with `mode: .nsLog` it will always work, wether logging is enabled or not.

let settings = Log.shared.settings

settings.isEnabled = true
settings.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
settings.template = "{date} -- [{thread}] {file} ({line}) -> {function} > {text}"

/// - Note: toggle logging for specific files like this:
settings.files = [
    "AppDelegate" : false,
    "ViewController" : true
]

/// LogDelegate

Log.shared.delegate = self

func didLog(line: Line, mode: Log.Mode) {
    /// - Note: do something here?
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
