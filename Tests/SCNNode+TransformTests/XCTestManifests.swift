import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SCNNode_TransformTests.allTests),
    ]
}
#endif
