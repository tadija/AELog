import XCTest

extension AELogTests {
    static let __allTests = [
        ("testLogPerformance", testLogPerformance),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AELogTests.__allTests),
    ]
}
#endif
