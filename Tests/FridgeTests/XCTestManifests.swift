import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FridgeTests.allTests),
        testCase(FreezerTests.allTests)
    ]
}
#endif
