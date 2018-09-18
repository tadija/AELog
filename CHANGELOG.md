# Changelog

## Version 0.5.6

- Bumped Swift language version to 4.2 with Xcode 10 (10A255)
- Reorganizing project directories and files

## Version 0.5.5

- Renamed main API into `aelog` (again)
- Major improvements and refactoring

## Version 0.5.1

- Minor improvements

## Version 0.5.0

- Major improvements and refactoring
- Introduced `Log.Mode` for using `print` or `NSLog`
- Renamed main API into `logToDebugger` and `logToDevice`

## Version 0.4.1

- Minor improvements and refactoring

## Version 0.4.0

- Renamed class `AELog` to `Log`
- Renamed function `aelog` to `log(message:)`
- Added utility function `log(elements:)` to quickly log random stuff
- Replaced `Config` (from .plist file) with `Settings` class (configure via code)
- Other fixes and improvements

## Version 0.3.2

- Migrated to Swift 4 and recommended settings with Xcode 9.2

## Version 0.3.1

- Minor fixes

## Version 0.3.0

- Fixed all build warnings and errors in Xcode 8.1 Beta (8T47)
- Code updated for Swift 3.0 ("swiftyfying")
- Sources reorganized from single to multiple files

## Version 0.2.4

- Logging is now done on dedicated serial queue
- Thread name logic is improved

## Version 0.2.3

- Logging is now done async, but delegate is called on main thread

## Version 0.2.2

- Fixed thread name ("Unknown" instead of empty string)

## Version 0.2.1

- Ready for release

## Version 0.1.0

- Initial version
