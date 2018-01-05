/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import XCTest
@testable import AELog

class AELogTests: XCTestCase, LogDelegate {
    
    fileprivate var timestamp = Date()
    
    override func setUp() {
        super.setUp()
        Log.launch(with: self)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLogPerformance() {
        self.measure {
            log(message: "test message")
        }
    }
    
    func didLog(line: Line) {
        timestamp = line.date
        testLogLine(line)
    }
    
    func testLogLine(_ line: Line) {
        XCTAssertEqual(timestamp, line.date)
        XCTAssertEqual(Thread.main, line.thread)
        XCTAssertEqual("AELogTests", line.file)
        XCTAssertEqual(43, line.number)
        XCTAssertEqual("testLogPerformance()", line.function)
        XCTAssertEqual("test message", line.message)
    }
    
}
