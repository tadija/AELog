/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2022 Marko Tadić
 *  Licensed under the MIT license
 */

import XCTest
@testable import AELog

class AELogTests: XCTestCase, LogDelegate {
    
    fileprivate var timestamp = Date()
    
    override func setUp() {
        super.setUp()
        Log.shared.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLogPerformance() {
        self.measure {
            aelog("test log text")
        }
    }

    func didLog(line: Line, mode: Log.Mode) {
        timestamp = line.date
        testLogLine(line)
    }

    func testLogLine(_ line: Line) {
        XCTAssertEqual(timestamp, line.date)
        XCTAssertEqual(Thread.main, line.thread)
        XCTAssertEqual("AELogTests", line.file)
        XCTAssertEqual(25, line.number)
        XCTAssertEqual("testLogPerformance()", line.function)
        XCTAssertEqual("test log text", line.text)
    }
    
}
